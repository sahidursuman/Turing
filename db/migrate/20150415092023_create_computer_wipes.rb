class CreateComputerWipes < ActiveRecord::Migration
  def change
    create_table :computer_wipes do |t|
      t.integer :wipe_id, :computer_id
    end
  end
end
