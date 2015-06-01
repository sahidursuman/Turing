class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|
      t.string :hub_location
      t.string :hub_fao
      t.timestamps
    end
  end
end
