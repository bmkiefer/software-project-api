class Api::V1::FollowedController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
    before_filter :authenticate_user!

   respond_to :json

  def index

    my_follows = current_user.followed_users.pluck(:id, :name)

    render :status => 200,
           :json => { :success => true,
                      :info => "My Followed Users",
                      :data => {
				 :users => my_follows
                               }
                    }           

  end
end
