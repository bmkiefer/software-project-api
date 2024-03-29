class Api::V1::TextsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
 #  before_filter :authenticate_user!

  respond_to :json

  def index

    content_element = ContentElement.first

    render :status => 200,
           :json => { :success => true,
                      :info => "Content Element Fetched",
                      :data => {

                                   "content_element" => content_element.picture

                               }
                    }

  end


  def create

    new_element = ContentElement.create!(:poll_id => params[:content_element][:poll_id], :content_type => 2 , :content_text => params[:content_element][:text], :picture => nil)

    new_element.save

    render :status => 200,
           :json => { :success => true,
                      :info => "Content Element Created",
                      :data => {}
                    }
  end
end
