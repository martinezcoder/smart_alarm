require 'rails_helper'

describe EndpointsController do
  before(:each) do
    @alarm = FactoryGirl.create(:endpoint, interval: 60*15)
  end

  describe 'POST /execute' do
    it "should call the worker" do
      post :execute, uuid: @alarm.id
      expect(AlertWorker).to have_enqueued_job(@alarm.id)
    end
  end
end
