class Api::V1::SkipsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
 #  before_filter :authenticate_user!

  respond_to :json

  def create

    new_poll = Poll.create!( :description => params[:poll][:description] , :display_type => 1)
    render :status => 200,
           :json => { :success => true,
                      :info => "Content Element Created",
                      :data => { :id => new_poll.id  }
                    }
  end
end
