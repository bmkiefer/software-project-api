class AddPictureToContentElements < ActiveRecord::Migration
  def self.up
    add_attachment :content_elements, :picture
  end

  def self.down
    remove_attachment :content_elements, :picture
  end
end
