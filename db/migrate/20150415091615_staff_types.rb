class StaffTypes < ActiveRecord::Migration
  def change
    create_table :staff_types do |t|
      t.integer :type_id, :staff_id
    end
  end
end
