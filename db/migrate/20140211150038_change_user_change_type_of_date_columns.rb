class ChangeUserChangeTypeOfDateColumns < ActiveRecord::Migration
  def up
  	change_column(:users, :start_date, :date)
  end

  def down
    change_column(:users, :start_date, :datetime)
  end
end
