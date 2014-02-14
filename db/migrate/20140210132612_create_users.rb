class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
