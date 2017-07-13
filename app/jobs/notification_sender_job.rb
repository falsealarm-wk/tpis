class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform
    send_notification
  end

  def send_notification
    Employee.with_expired_documents.find_each do |employee|
      documents = employee.expired_documents.map {|entry| entry.document.code }.join(" , ")
      NotificationMailer.notification(employee, documents).deliver_later
    end
  end

  def send_request
    Employee.with_expired_documents.find_each do |employee|
      documents = employee.expired_documents.map {|entry| entry.document.code }.join(" , ")
      NotificationMailer.notification(employee, documents).deliver_later
    end
  end
end
