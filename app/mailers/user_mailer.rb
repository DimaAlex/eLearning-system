class UserMailer < ApplicationMailer
  def invitation_instractions(email, organization)
    @email = email
    @organization  = organization
    mail(to: @email, subject: 'Invitation instructions')
  end
end
