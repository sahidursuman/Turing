class CreateDonor < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.string :donor_name
      t.string :donor_email
      t.text :donor_address
      t.boolean :paper_cert, :default => false
      t.boolean :allow_mail, :default => false
      t.timestamps
    end
  end
end
