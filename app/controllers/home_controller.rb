class HomeController < ApplicationController
  def index
    @posts = Post.all.order(created_at: "desc")
  end

  def wiki
  end

  def sites
  end

  def search
    @q = params[:q]
    if @q.present?
      search = Post.search { fulltext params[:q] }
      @result = search.results
    else
      @result = []
    end
  end
end
