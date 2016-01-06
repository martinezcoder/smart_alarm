namespace :notify_expired do
  task run: :environment do
    expired = Endpoint.where("expires_at < ? and retries < ?", Time.now.to_i, 3).pluck(:id)
    expired.each do |alarm_uuid|
      AlertWorker.perform_async(alarm_uuid, true)
    end
  end
end

