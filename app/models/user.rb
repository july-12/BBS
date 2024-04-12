class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, uniqueness: true
  validates :phone, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
