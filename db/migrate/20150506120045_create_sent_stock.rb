class CreateSentStock < ActiveRecord::Migration
  def change
    create_table :sent_stocks do |t|
      t.integer :sent_keyboards
      t.integer :sent_mice 
      t.integer :sent_monitors
      t.integer :sent_printers
      t.integer :sent_speakers
      t.integer :staff_id
      t.timestamps
    end
  end
end
