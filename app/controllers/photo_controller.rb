class PhotoController < ApplicationController
  # before_action :authenticate_user!, only: [:create, :update, :destroy, :favorite, :unfavorite]

  def create
    phone = Photo.new(phone_param)
    if phone.save
      render json: { url: phone.image_url }
    else
      render json: { msg: "upload failed" }, status: :unprocessable_entity
    end
  end

  private

  def phone_param
    params.require(:phone).permit(:image)
  end
end
