class UserMailer < ApplicationMailer
  # def account_activation(user)
  #   @user = user
  #   mail to: user.email, subject: "Account activation"
  # end

  def signup_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "Registration")
  end

end
