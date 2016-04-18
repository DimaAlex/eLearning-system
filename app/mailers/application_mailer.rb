class ApplicationMailer < ActionMailer::Base
  default from: ENV["email"]
end
