class CreateStaff < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :staff_name
      t.string :staff_email
      t.timestamps
    end
  end
end
