class ChangeLineManagerToString < ActiveRecord::Migration
  def up
  	change_column(:users, :line_manager, :string)
  end

  def down
  	change_column(:users, :line_manager, :integer)
  end
end