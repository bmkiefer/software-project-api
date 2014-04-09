class SkippedElement < ActiveRecord::Base

  belongs_to :content_element
  belongs_to :user

end
