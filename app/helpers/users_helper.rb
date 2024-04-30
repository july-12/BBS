module UsersHelper
  def is_follow?(user)
    current_user.followings.exist? user.id
  end

  def profile_layout_class_name(active)
    active ? "inline-flex items-center px-4 py-3 text-white bg-blue-700 rounded-lg active w-full dark:bg-blue-600" : "inline-flex items-center px-4 py-3 rounded-lg hover:text-gray-900 bg-gray-50 hover:bg-gray-100 w-full dark:bg-gray-800 dark:hover:bg-gray-700 dark:hover:text-white"
  end

  def profile_tab_class_name(active)
    active ? "inline-block p-3 text-blue-600 bg-gray-100 rounded-t-lg bg-white active dark:bg-gray-800 dark:text-blue-500" : "inline-block p-3 rounded-t-lg hover:text-gray-600 hover:bg-gray-50 dark:hover:bg-gray-800 dark:hover:text-gray-300"
  end
end
