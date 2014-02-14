class AddHoursPerWeekToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hours_per_week, :integer
  end
end
