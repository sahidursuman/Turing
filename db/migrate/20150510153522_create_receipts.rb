class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.integer :entertrack
      t.integer :staff_id
      t.integer :computer_id
      t.boolean :received, :default => false
      t.timestamps
    end
  end
end
