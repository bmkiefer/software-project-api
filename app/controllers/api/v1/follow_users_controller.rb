class Api::V1::FollowUsersController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
    before_filter :authenticate_user!

   respond_to :json

  def create

    user_follow = Relationship.find_by_follower_id_and_followed_id(current_user.id,params[:user][:id])

    if user_follow.nil?
      Relationship.create(:follower_id => current_user.id, :followed_id => params[:user][:id])
    else
      user_follow.delete
    end

    render :status => 200,
           :json => { :success => true,
                      :info => "Follow Toggled",
                      :data => {
                               }
                    }           

  end
end
