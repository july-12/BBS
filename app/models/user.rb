class User < ApplicationRecord
  extend FriendlyId
  attr_writer :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, uniqueness: { case_sensitive: true }, presence: true
  validates :phone, uniqueness: true, format: { with: /\A1[3|4|5|7|8][0-9]{9}\z/, message: "format is invalid" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github],
                        authentication_keys: [:login]

  has_many :posts, inverse_of: :author

  has_many :favorites, class_name: "Favorite"
  has_many :favorite_posts, through: :favorites, source: :operatable, source_type: "Post"

  has_many :likes, class_name: "Like"
  has_many :like_posts, through: :likes, source: :operatable, source_type: "Post"
  has_many :like_comments, through: :likes, source: :operatable, source_type: "Comment"

  has_many :subscribes, class_name: "Subscribe"
  has_many :subscribe_posts, through: :subscribes, source: :operatable, source_type: "Post"

  has_many :questions, inverse_of: :author
  has_many :comments, inverse_of: :commenter

  has_many :follower_relations, class_name: "Follow", foreign_key: :following_id, inverse_of: :following
  has_many :following_relations, class_name: "Follow", foreign_key: :follower_id, inverse_of: :follower
  has_many :followers, through: :follower_relations
  has_many :followings, through: :following_relations

  has_one_attached :avatar

  friendly_id :name, use: :slugged

  enum role: [:admin, :normal]
  enum status: [:silence]

  default_scope -> { where(status: nil) }

  def login
    @login || self.phone || self.name
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(["lower(name) = :value OR lower(phone) = :value", { :value => login.downcase }]).first
    else
      # https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address#allow-users-to-recover-their-password-or-confirm-their-account-using-their-username
      where(conditions).first
      # if conditions[:email].nil?
      #   where(conditions).first
      # else
      #   where(phone: conditions[:phone]).first
      # end
    end
  end

  def favorite_post?(post_id)
    #  favorites.exists?(operatable_type: "Post", operatable_id: post_id)
    favorite_post_ids.include?(post_id)
  end

  def like_post?(post_id)
    like_post_ids.include?(post_id)
  end

  def like_comment?(comments_id)
    like_comment_ids.include?(comments_id)
  end

  def subscribe_post?(post_id)
    subscribe_post_ids.include?(post_id)
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.phone = ""  # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def is_admin?
    return true
  end
end
