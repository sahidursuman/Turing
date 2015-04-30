class CreateWipes < ActiveRecord::Migration
  def change
    create_table :wipes do |t|
      t.integer :staff_id
      t.integer :computer_id
      t.text :action_taken
      t.timestamps
    end
  end
end
