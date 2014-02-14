class RemoveEndDateFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :end_date, :datetime
  end
end
