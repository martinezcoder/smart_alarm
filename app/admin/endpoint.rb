ActiveAdmin.register Endpoint do
  permit_params :name, :state, :expires, :sent_alert, :retries

  index do
    column :name
    column :state
    column :expires
    column :sent_alert
    column :retries
    actions
  end

  form do |f|
    f.inputs "Endpoint" do
      f.input :name
      f.input :state, as: :select, collection: Endpoint.states.keys
      f.input :expires
      f.input :sent_alert
      f.input :retries
    end
    f.actions
  end
end
