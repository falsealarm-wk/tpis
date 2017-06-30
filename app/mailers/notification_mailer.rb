class NotificationMailer < ApplicationMailer
  def notification(user, documents)
    @user = user
    @documents = documents
    if user.email
      mail to: user.email
    end
  end
end
