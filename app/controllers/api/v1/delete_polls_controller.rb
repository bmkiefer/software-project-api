class Api::V1::DeletePollsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def delete
        
    Poll.find(params[:poll][:id]).delete

    render :status => 200,
           :json => { :success => true,
                      :info => "Poll Deleted",
                      :data => { }
                    }
  end

end
