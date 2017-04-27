ActiveAdmin.register Entry do
  permit_params :employee_id, :document_id, :expired_at, :closed

end
