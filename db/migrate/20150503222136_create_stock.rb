class CreateStock < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :keyboards
      t.integer :mice 
      t.integer :monitors
      t.integer :printers
      t.integer :speakers
      t.timestamps
    end
  end
end
