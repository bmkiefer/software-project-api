class AddExpirationDates < ActiveRecord::Migration
  def change
    add_column :polls, :expiration_date, :datetime
  end
end
