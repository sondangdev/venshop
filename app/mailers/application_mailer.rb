class ApplicationMailer < ActionMailer::Base
  default from: "Son Dang <#{ENV['GMAIL_USERNAME']}>"
  layout 'mailer'
end
