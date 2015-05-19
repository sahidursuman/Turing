class CreateStock < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :batch_name
      t.integer :keyboards
      t.integer :mice 
      t.integer :monitors
      t.integer :printers
      t.integer :speakers
      t.integer :vga_cables
      t.integer :kettle_leads
      t.integer :routers
      t.integer :lan_switches
      t.integer :staff_id
      t.timestamps
    end
  end
end