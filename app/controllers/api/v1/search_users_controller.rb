class Api::V1::SearchUsersController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
    before_filter :authenticate_user!

   respond_to :json

  def create
   search_condition = "%" + params[:search][:keyword] + "%"
    users = User.where.not(:id => current_user.id).where('name ILIKE ?', search_condition).map { |e| { id: e.id, name: e.name } }
    
    users.each do |user|
	found_user = User.find(user[:id])
	if current_user.following?(found_user)
	   user[:following] = 1
        else
           user[:following] = 0
        end

    end

    render :status => 200,
      :json => { 
        :success => true,
        :info => "Searched Users",
        :data =>{:users =>  users }
      }

  end
end
