class Api::V1::OtherUserPollsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def show
    other_polls = Poll.where(:user_id => params[:user][:id]).map { |e| { id: e.id, description: e.description } }

    other_polls.each do |poll|
	elements = ContentElement.where(:poll_id => poll[:id]).pluck(:id)
        if VotedOn.where(:user_id => current_user.id).where(:content_element_id => elements).length > 0
	   poll[:voted_on] = 1
        else
           poll[:voted_on] = 0
        end

    end
    
    render :status => 200,
           :json => { :success => true,
                      :info => "User's Polls",
                      :data => {
				 :other_polls => other_polls
                               }
                    }
  end

  def delete
        
    Poll.find(params[:poll][:id]).delete

    render :status => 200,
           :json => { :success => true,
                      :info => "Poll Deleted",
                      :data => { }
                    }
  end

  def index

    total_polls = Poll.where.not(:created => nil).where(:user_id => current_user.id).length

    if total_polls > 0

    my_poll = Poll.find(params[:poll][:id])

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

    my_elements = ContentElement.where( :poll_id => my_poll.id).pluck(:id)

    total = VotedOn.where( :content_element_id => my_elements).length

    element1_count = VotedOn.where( :content_element_id => my_elements.first).length

    element2_count = VotedOn.where( :content_element_id => my_elements.last).length

    render :status => 200,
           :json => { :success => true,
                      :info => "Poll Fetched",
                      :data => {
				  :id => my_poll.id,
				  :votes => total,
				  :element1 => {
				      :id => element1.id,
                                      :picture => element1_picture,
                                      :text => element1.content_text,
				      :votes => element1_count
				  },
				  :element2 => {
				      :id => element2.id,
				      :picture => element2_picture,
				      :text => element2.content_text,
				      :votes => element2_count
				  },
				  :description => my_poll.description					  
                               }
                    }


    else

    render :status => 200,
           :json => { :success => true,
                      :info => "No Polls",
                      :data => {
                               }
                    }




    end

  end
end
