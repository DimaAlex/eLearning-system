class UserMailer < ApplicationMailer
  def invitation_instractions(user, current_user, organization)
    @user = user
    @organization  = organization
    @current_user = current_user
    mail(to: @user.email, subject: 'Invitation instructions')
  end
end
