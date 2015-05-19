class CreateSentStock < ActiveRecord::Migration
  def change
    create_table :sent_stocks do |t|
      t.string :sent_batch_name
      t.integer :sent_keyboards
      t.integer :sent_mice 
      t.integer :sent_monitors
      t.integer :sent_printers
      t.integer :sent_speakers
      t.integer :sent_vga_cables
      t.integer :sent_kettle_leads
      t.integer :sent_routers
      t.integer :sent_lan_switches
      t.integer :staff_id
      t.timestamps
    end
  end
end
