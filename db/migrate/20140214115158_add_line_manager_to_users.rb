class AddLineManagerToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :line_manager, :integer
  end
end
