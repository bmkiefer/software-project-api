class Poll < ActiveRecord::Base

  belongs_to :user
  has_many :content_elements
 
end
