ActiveAdmin.register Employee do
  permit_params :name, :email, :department, :phone, :model

end
