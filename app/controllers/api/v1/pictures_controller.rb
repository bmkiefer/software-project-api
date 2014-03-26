class Api::V1::PicturesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
 #  before_filter :authenticate_user!

  respond_to :json

  def index


    render :status => 200,
           :json => { :success => true,
                      :info => "My Subscriptions",
                      :data => {

                                   "providers" => "this"

                               }
                    }

  end


  def create

    render :status => 200,
           :json => { :success => true,
                      :info => "My Subscriptions",
                      :data => {
                                   "providers" => "this"
                               }
                    }
  end
end
