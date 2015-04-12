class AddStaffIdToComputers < ActiveRecord::Migration
  def change
    # add_column :table_to_apply_change to, :field_to_add, :type
    add_column :computers, :staff_id, :integer
  end
end