class Api::V1::SkipsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def create

    SkippedElement.create!( :poll_id => params[:poll][:id] , :user_id => current_user.id )
    render :status => 200,
           :json => { :success => true,
                      :info => "Poll Skipped",
                      :data => { }
                    }
  end
end
