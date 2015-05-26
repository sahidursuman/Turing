class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.integer :entertrack
      t.integer :staff_id
      t.integer :computer_id
      t.boolean :shipped, :default => true
      t.timestamps
    end
  end
end