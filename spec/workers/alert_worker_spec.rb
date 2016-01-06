require 'rails_helper'

describe AlertWorker do
  before(:each) do
    @alarm = FactoryGirl.create(:endpoint, interval: 60*15)
  end

  it { should be_retryable true }

  it "enqueues a communication worker" do
    AlertWorker.perform_async(@alarm.id, true)
    expect(AlertWorker).to have_enqueued_job(@alarm.id, true)
  end

  it 'should increase retries if is an expiration' do
    expect {
      AlertWorker.new.perform(@alarm.id, true)
    }.to change{Endpoint.find(@alarm.id).retries}.from(0).to(1)
  end

  it 'should set retries to 0 if it was a zombie alarm and it got back to normal' do
    @alarm.update_attributes(retries: 1, status: Endpoint.statuses[:zombie])
    expect {
      AlertWorker.new.perform(@alarm.id)
    }.to change{Endpoint.find(@alarm.id).retries}.from(1).to(0)
  end
end
