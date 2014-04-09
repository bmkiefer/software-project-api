class Api::V1::VotesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
    before_filter :authenticate_user!

   respond_to :json

  def create

    VotedOn.create!( :user_id => current_user.id, :content_element_id => params[:content_element][:id] )
    
    render :status => 200,
           :json => { :success => true,
                      :info => "Vote Complete",
                      :data => { }
                    }
  end
end