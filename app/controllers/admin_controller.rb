class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorization

  private

  def authorization
    redirect_to root_path unless current_user.admin?
  end
end
