class UserMailer < ApplicationMailer
  default from: 'windowsloveubuntu@163.com'

  def assign_task(user)
    @user = user
    mail(to: @user.email, subject: "") if @user.email.present?
  end
end
