class AddPdfEmailToStaff < ActiveRecord::Migration
  def change
    add_column :staffs, :barcode_pdf_email , :string
  end
end
