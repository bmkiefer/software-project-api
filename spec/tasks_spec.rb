#require "spec_helper"
require_relative '../spec/spec_helper'

#spec/requests/api/v1/tasks_spec.rb
describe "Tasks API" do
  it 'should return tasks' do
   # FactoryGirl.create_list(:message, 10)

    get '/api/v1/tasks'

    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)
  end
end
