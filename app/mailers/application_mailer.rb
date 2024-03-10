# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  BASE_SENDER = Rails.application.credentials.base_mail_sender

  default from: "Inicro #{BASE_SENDER}"
  layout 'mailer'
end
