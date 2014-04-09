class CreateSkippedElements < ActiveRecord::Migration
  def change
    create_table :skipped_elements do |t|
      t.references :user
      t.references :poll
    end
  end
end
