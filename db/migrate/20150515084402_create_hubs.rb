class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|
      t.string :hub_location
    end
  end
end
