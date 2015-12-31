ActiveAdmin.register User do
  index do
    id_column
    column :email
    column :name
    actions
  end
end
