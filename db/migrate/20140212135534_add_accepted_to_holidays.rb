class AddAcceptedToHolidays < ActiveRecord::Migration
  def change
    add_column :holidays, :accepted, :boolean, default: false
  end
end
