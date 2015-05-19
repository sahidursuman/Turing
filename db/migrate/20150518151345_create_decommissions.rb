class CreateDecommissions < ActiveRecord::Migration
  def change
    create_table :decommissions do |t|
      t.integer :entertrack
      t.integer :staff_id
      t.integer :computer_id
      t.boolean :decommissioned, :default => false
      t.timestamps
    end
  end
end