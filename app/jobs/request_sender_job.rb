class RequestSenderJob < ApplicationJob
  queue_as :default

  after_perform :update_request_status

  def perform(request)
    @request = request
    send_request
  end

  def send_request
    entries = @request.entries.includes(:document).pluck(:code)
    RequestMailer.notification(@request.employee, entries).deliver_later
  end

  def update_request_status
    @request.update!(sent: true)
  end
end
