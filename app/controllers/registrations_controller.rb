class RegistrationsController < Devise::RegistrationsController
  def create
    email = params[:user][:email]
    email.blank? || WhiteList.find_by_email_ignore_case(email) ?
        super : (redirect_to root_path,
        alert: 'Hey, you are not allow to register. Please ask Little Star Early Learning Centre for permission.')
  end
end
