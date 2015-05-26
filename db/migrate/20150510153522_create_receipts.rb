class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.integer :entertrack
      t.integer :staff_id
      t.integer :computer_id
      t.string :school
      t.boolean :received, :default => true
      t.timestamps
    end
  end
end
