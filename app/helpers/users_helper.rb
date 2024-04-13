module UsersHelper
  def is_follow?(user)
    current_user.followings.exist? user.id
  end
end
