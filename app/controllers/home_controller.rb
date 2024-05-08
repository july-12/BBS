class HomeController < ApplicationController
  def index
    @posts = Post.all.order(created_at: "desc")
  end

  def wiki
  end

  def sites
  end
end
