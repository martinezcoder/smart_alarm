ActiveAdmin.register Endpoint do
  permit_params :name, :status, :expires_at, :sent_alert, :retries

  index do
    column :name
    column :status
    column :expires_at
    column :sent_alert
    column :retries
    actions
  end

  form do |f|
    f.inputs "Endpoint" do
      f.input :name
      f.input :status, as: :select, collection: Endpoint.statuses.keys
      f.input :expires_at
      f.input :sent_alert
      f.input :retries
    end
    f.actions
  end
end
