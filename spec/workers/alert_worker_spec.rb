require 'rails_helper'

describe AlertWorker do
  before(:each) do
    EmailService.any_instance.stub(:send).and_return(true)
    @user = FactoryGirl.create(:user)
    @alarm = FactoryGirl.create(:endpoint, interval: 60*15, user: @user)
    @alarm.contacts << FactoryGirl.create(:contact, user: @user)
  end

  it { should be_retryable false }

  it "enqueues a communication worker" do
    expect {
      AlertWorker.perform_async(@alarm.id, true)
    }.to change(AlertWorker.jobs, :size).by(1)
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
