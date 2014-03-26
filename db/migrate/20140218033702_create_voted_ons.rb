class CreateVotedOns < ActiveRecord::Migration
  def change
    create_table :voted_ons do |t|
      t.references :user
      t.references :content_element
    end
  end
end
