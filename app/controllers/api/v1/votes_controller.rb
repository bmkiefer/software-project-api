class Api::V1::VotesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
    before_filter :authenticate_user!

   respond_to :json

  def create

    VotedOn.create!( :user_id => current_user.id, :content_element_id => params[:content_element][:id] )
	    
    my_elements = ContentElement.where( poll_id => ContentElement.find(params[:content_element][:id]).poll_id).pluck(:id)

    total = VotedOn.where( :content_element_id => my_elements).length

    element1 = VotedOn.where( :content_element_id => my_elements.first).length

    element2 = VotedOn.where( :content_element_id => my_elements.last).length

    render :status => 200,
           :json => { :success => true,
                      :info => "Vote Complete",
                      :data => {
				 :poll =>{
				    :votes => total	
				},
				:element1 => {
				    :votes => element1
				},
				:element2 => {
				    :votes => element2
                                }
				
				
			        }
                    }
  end
end
