class RequestMailer < ApplicationMailer
  def notification(employee, entries, new_documents)
    @employee = employee
    @entries = entries
    @new_documents = new_documents
    if (@entries || @new_documents)
      mail to: User.admin.email
    end
  end
end
