class PostMailer < ApplicationMailer
  # default from: "seventanyb@gmail.com"
  default from: "370403679@qq.com"

  def subscribe
    @user = params[:user]
    # @url = "yubtan@icloud.com"
    @url = "seventanyb@gmail.com"
    mail(to: @url, subject: "rails test mail by qq stmp mail!")
  end
end
