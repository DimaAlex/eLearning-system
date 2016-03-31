class UserMailer < ApplicationMailer
  def invitation_instractions(user, organization)
    @user = user
    @organization  = organization
    mail(to: @user.email, subject: 'Invitation instructions')
  end
end
