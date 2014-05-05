ass Api::V1::ResetPasswordController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def create
	user = User.find_by_email(params[:email])

	if change.hidden_flag != nil
	  user.send_reset_password_instructions
	end

	render :status => 200,
           :json => { :success => true,
                      :info => "If Email was found and Email was sent",
                      :data => { }
                    }
  end

end
