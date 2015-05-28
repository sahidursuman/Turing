class CreateOperatingSystems < ActiveRecord::Migration
  def change
    create_table :operating_systems do |t|
      t.string :os
      t.timestamps
    end
  end
end
