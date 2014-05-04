class Api::V1::SearchUsersController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
    before_filter :authenticate_user!

   respond_to :json

  def create
   search_condition = "%" + params[:search][:keyword] + "%"
    users = User.where('name ILIKE ?', search_condition).pluck(:id, :name)

    render :status => 200,
      :json => { 
        :success => true,
        :info => "Searched Users",
        :data =>{:users =>  users }
      }

  end
end
