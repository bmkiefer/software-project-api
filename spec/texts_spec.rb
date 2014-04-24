
require_relative '../spec/spec_helper'

#spec/requests/api/v1/polls_spec.rb
describe "Texts API" do

  context 'happy routes' do

   it 'should create a user on good credentials' do

    post '/api/v1/registrations', :user => { "name" => "my_nigga", "email" => "user@example.com", "password" => "secret", "password_confirmation" => "secret" }

    json = JSON.parse(response.body)

    if response.status != 422

    expect(response.status).to eq 200            # test for the 200 status-code
    expect(json['info']).to eq 'Registered'             # test for correct info

    end

  end


  it 'should return an auth token on successful login' do

    post '/api/v1/sessions', :user => { "email" => "user@example.com", "password" => "secret" }

    expect(response.status).to eq 200            # test for the 200 status-code
    json = JSON.parse(response.body) 
    expect(json['info']).to eq 'Logged in'             # test for correct info
    auth_token = json['data']['auth_token']

  end

  it 'should sign out on auth_token passed to log out' do
    
    post '/api/v1/sessions', :user => { "email" => "user@example.com", "password" => "secret" }
    json = JSON.parse(response.body)
     auth_token = json['data']['auth_token']

    delete_string = '/api/v1/sessions?auth_token=' + auth_token

    delete delete_string

    expect(response.status).to eq 200            # test for the 200 status-code
    json = JSON.parse(response.body)
    expect(json['info']).to eq 'Logged out'             # test for correct info

  end

  end

  context 'sad routes' do

   it 'should not create a user on bad credentials' do

    post '/api/v1/registrations', :user => { "name" => "my_nigga", "email" => "user57@example.com", "password" => "secret1", "password_confirmation" => "secret" }

    expect(response.status).to eq 422            # test for the 200 status-code
    json = JSON.parse(response.body)
    expect(json['info']['password_confirmation']).to eq ["doesn\'t match Password"]             # test for correct info
  end


  it 'should not return an auth token on unsuccessful login' do

    post '/api/v1/sessions', :user => { "email" => "user@example.com", "password" => "secret2" }

    expect(response.status).to eq 401            # test for the 200 status-code
    json = JSON.parse(response.body)
    expect(json['info']).to eq 'Login Failed'             # test for correct info
    expect(json['data']['auth_token']).to equal(nil)

  end

  it 'should not authorize access to signout without auth_token' do

    delete '/api/v1/sessions'

    expect(response.status).to eq 401            # test for the 200 status-code
    json = JSON.parse(response.body)

  end
end
end
