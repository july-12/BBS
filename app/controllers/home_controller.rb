class HomeController < ApplicationController
  def index
    @user = { name: "tanyb" }
    render layout: false
  end
end
