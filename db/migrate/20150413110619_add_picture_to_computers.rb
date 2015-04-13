class AddPictureToComputers < ActiveRecord::Migration
  def change
    add_column :computers, :picture, :string
  end
end
