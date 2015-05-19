class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :entertrack
      t.integer :staff_id
      t.integer :computer_id
      t.boolean :scrapped, :default => false
      t.boolean :sold, :default => false
      t.timestamps
    end
  end
end
