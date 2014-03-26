class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :display_type
      t.string :description    

    end
  end
end
