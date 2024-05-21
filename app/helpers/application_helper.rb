module ApplicationHelper
  def url_profile(user)
    slug_path(user)
  end

  def active_link(pathname)
    current_page?(pathname) ? "text-blue-500" : nil
  end

  def active_nav_link(pathname)
    current_page?(pathname) ? "text-blue-500 bg-blue-200" : nil
  end
end
