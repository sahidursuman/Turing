class CreateWipes < ActiveRecord::Migration
  def change
    create_table :wipes do |t|
      t.date :date_wiped
      t.text :wiped_using
      t.string :wiped_by
    end
  end
end
