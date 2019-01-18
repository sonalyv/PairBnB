class ApplicationMailer < ActionMailer::Base
  default from: 'confirmation@pairbnb.com'
  layout 'mailer'
end
