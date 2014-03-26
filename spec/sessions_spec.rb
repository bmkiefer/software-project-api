#require "spec_helper"
require_relative '../spec/spec_helper'

#spec/requests/api/v1/tasks_spec.rb
describe "Sessions API" do

  let(:accept_json) { { "Accept" => "application/json" } }
  let(:json_content_type) { { "Content-Type" => "application/json" } }
  let(:accept_and_return_json) { accept_json.merge(json_content_type) }
#  let(:user) { FactoryGirl.create(:user)} 
  user = User.create!(:name => "bmkiefer, :email => "user1@example.com", :password => "secret", :password_confirmation => "secret")
  user.skip_confirmation!
  user.save

  let(:user_params) {
       { "user" => { "email" => "user1@example.com", "password" => "secret" } }
    }

  it 'should return an auth token on successful login' do

    post '/api/v1/sessions',:user_params.to_json,accept_and_return_json

    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)
  end
end
