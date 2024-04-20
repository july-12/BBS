class User < ApplicationRecord
  attr_writer :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, uniqueness: { case_sensitive: true }
  validates :phone, uniqueness: true, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  has_many :posts, inverse_of: :author
  has_many :favorites, class_name: "Favorite"
  has_many :likes, class_name: "Like"
  has_many :subscribes, class_name: "Subscribe"
  has_many :questions, inverse_of: :author
  has_many :comments, inverse_of: :commenter

  has_many :follower_relations, class_name: "Follow", foreign_key: :following_id, inverse_of: :following
  has_many :following_relations, class_name: "Follow", foreign_key: :follower_id, inverse_of: :follower
  has_many :followers, through: :follower_relations
  has_many :followings, through: :following_relations

  def login
    @login || self.phone || self.name
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(["lower(name) = :value OR lower(phone) = :value", { :value => login.downcase }]).first
    else
      if conditions[:phone].nil?
        where(conditions).first
      else
        where(phone: conditions[:phone]).first
      end
    end
  end

  def favorite_post?(post_id)
    favorites.where(post_id: post_id).exists?
  end

  def like_post?(post_id)
    likes.where(post_id: post_id).exists?
  end

  def subscribe_post?(post_id)
    subscribes.where(post_id: post_id).exists?
  end

  # def email_required?
  #   false
  # end

  # def email_changed?
  #   false
  # end
end
