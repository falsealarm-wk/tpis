class NotificationMailer < ApplicationMailer
  def notification(user, documents)
    @user = user
    @documents = documents
    mail to: user.email
  end
end
