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



   # decoded_file = Base64.decode64(params[:content_element][:picture])
    
   # begin
   #   file = Tempfile.new(['test', '.jpg']) 
   #   file.binmode
   #   file.write decoded_file
   #   file.close
   #   new_element = ContentElement.create!(:poll_id => params[:content_element][:poll_id] , :content_type => 1, :content_text => "", :picture => file)
   # ensure
   #   file.unlink
   # end
 
   StringIO.open(Base64.decode64(params[:content_element][:picture])) do |data|
       data.class.class_eval { attr_accessor :original_filename, :content_type }
     # data.original_filename = DateTime.now.to_s + ".jpg"
      data.content_type =  "image/jpeg"
      new_element = ContentElement.create!(:poll_id => params[:content_element][:poll_id] , :content_type => 1, :content_text => "", :picture => data)
   end

    # new_element = ContentElement.create!(:poll_id => poll_id , :content_type => 1, :content_text => "", :picture => params[:picture])

    render :status => 200,
           :json => { :success => true,
                      :info => "Content Picture Created",
                      :data => {}
                    }
  end
end
