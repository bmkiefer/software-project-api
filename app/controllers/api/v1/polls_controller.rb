class Api::V1::PollsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def index

    my_poll = Poll.where(47)

    my_content =  ContentElement.where(:poll_id => my_poll.id)

    element1 = my_content.first
    element2 = my_content.last
	
    if !element1.picture_file_name.nil?
        element1_picture = Base64.encode64(open(element1.picture.url(:original)) { |io| io.read })
    else
    	element1_picture = ""
    end

    if !element2.picture_file_name.nil?	
	element2_picture = Base64.encode64(open(element2.picture.url(:original)) { |io| io.read })
    else
	element2_picture = ""
    end

    render :status => 200,
           :json => { :success => true,
                      :info => "Poll Fetched",
                      :data => {
				  :id => my_poll.id,
				  :element1 => {
				      :id => element1.id,
                                      :picture => element1_picture,
                                      :text => element1.content_text
				  },
				  :element2 => {
				      :id => element2.id,
				      :picture => element2_picture,
				      :text => element2.content_text
				  },
				  :description => my_poll.description					  
                               }
                    }

  end


  def create

    new_poll = Poll.create!( :description => params[:poll][:description] , :display_type => 1)
    render :status => 200,
           :json => { :success => true,
                      :info => "Poll Created",
                      :data => { :id => new_poll.id  }
                    }
  end
end
