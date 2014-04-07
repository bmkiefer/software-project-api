class Api::V1::PicturesController < ApplicationController
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
    poll_id = params[:content_element][:poll_id]
    new_element = ContentElement.create!(:poll_id => poll_id , :content_type => 1, :content_text => "", :picture => params[:picture])
    new_element.save

    render :status => 200,
           :json => { :success => true,
                      :info => "Content Element Created",
                      :data => {}
                    }
  end
end
