class AlertMailer < ApplicationMailer
  def notify(alert, email)
    @alert = alert
    mail(to: email, subject: alert.title)
  end
end
