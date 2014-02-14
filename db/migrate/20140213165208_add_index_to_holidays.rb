class AddIndexToHolidays < ActiveRecord::Migration
  def change
  	add_index :holidays, :user_id
  end
end
