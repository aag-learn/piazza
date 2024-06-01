# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "alfonso@#{Rails.application.config.outbound_email_domain}"
  layout 'mailer'
end
