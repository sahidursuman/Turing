class CreateDonor < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.string :donor_name
      t.string :donor_email
      t.boolean :allow_mail, default: false
      t.timestamps
    end
  end
end
