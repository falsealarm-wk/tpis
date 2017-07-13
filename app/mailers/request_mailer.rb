class RequestMailer < ApplicationMailer
  def notification(employee, entries)
    @employee = employee
    @entries = entries
    if @entries
      mail to: User.admin.email
    end
  end
end
