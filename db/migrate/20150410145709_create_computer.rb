class CreateComputer < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.string :manufacturer
      t.string :computer_type
      t.string :model_no
      t.string :serial_no
      t.date :date
      t.text :action_taken
      t.text :donor
      t.text :specification
      t.text :product_key
      t.string :initials_flag
      t.timestamps
    end
  end
end