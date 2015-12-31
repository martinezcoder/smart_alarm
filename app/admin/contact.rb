ActiveAdmin.register Contact do
  permit_params :email, :name, :user_id
end
