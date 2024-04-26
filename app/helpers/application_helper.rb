module ApplicationHelper
  def url_profile(user)
    user_profile_path(user.id)
  end
end
