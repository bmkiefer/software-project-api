class Api::V1::FollowersController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
    before_filter :authenticate_user!

   respond_to :json

  def index
   
    my_followers = current_user.followers.map { |e| { id: e.id, name: e.name } }

    render :status => 200,
           :json => { :success => true,
                      :info => "My Followers",
                      :data => {
				 :users => my_followers
                               }
                    }           

  end
end
