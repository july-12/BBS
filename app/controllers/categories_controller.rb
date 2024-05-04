class CategoriesController < ApplicationController
  def slug
    @category = Category.friendly.find(params[:slug].downcase)
    @posts = @category.posts.order(created_at: "DESC")
  rescue ActiveRecord::RecordNotFound
    render plain: "Not This Topic Found"
  end
end
