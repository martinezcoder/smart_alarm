ActiveAdmin.register Endpoint do
  permit_params :name, :state, :expires_at, :sent_alert, :retries

  index do
    column :name
    column :state
    column :expires_at
    column :sent_alert
    column :retries
    actions
  end

  form do |f|
    f.inputs "Endpoint" do
      f.input :name
      f.input :state, as: :select, collection: Endpoint.states.keys
      f.input :expires_at
      f.input :sent_alert
      f.input :retries
    end
    f.actions
  end
end
