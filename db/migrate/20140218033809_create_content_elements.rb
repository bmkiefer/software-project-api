class CreateAwayTeams < ActiveRecord::Migration
  def change
    create_table :content_elements do |t|
      t.references :poll
      t.integer :content_type
      t.string :content_text
    end
  end
end
