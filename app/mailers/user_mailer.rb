class UserMailer < ApplicationMailer
  def invitation_instractions(user, organization)
    @user = user
    @organization  = organization
    mail(to: @user.email, subject: 'Invitation instructions')
  end

  def invitation_to_course(user, course)
    @user = user
    @course = course
    mail(to: @user.email, subject: 'Invitation to individual course')
  end
end
