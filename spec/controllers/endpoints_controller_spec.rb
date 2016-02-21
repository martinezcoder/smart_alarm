require 'rails_helper'

describe EndpointsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @alarm = FactoryGirl.create(:endpoint, interval: 60*15, user: @user)
    @alarm.contacts << FactoryGirl.create(:contact, user: @user)
  end

  describe 'POST /execute' do
    it "should call the worker" do
    expect {
      post :execute, uuid: @alarm.id
    }.to change(AlertWorker.jobs, :size).by(1)
    end
  end
end
