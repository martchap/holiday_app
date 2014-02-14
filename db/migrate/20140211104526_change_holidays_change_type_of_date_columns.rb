class ChangeHolidaysChangeTypeOfDateColumns < ActiveRecord::Migration
  def up
  	change_column(:holidays, :start_date, :date)
  	change_column(:holidays, :end_date, :date)
  end

  def down
  	change_column(:holidays, :start_date, :datetime)
  	change_column(:holidays, :end_date, :datetime)
  end
end
