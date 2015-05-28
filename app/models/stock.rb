class Stock < ActiveRecord::Base
  belongs_to :staff
  
  validates :batch_name, length: { minimum: 3, maximum: 25 } ,allow_blank: true
  validates :keyboards, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :mice, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :monitors, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :printers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :speakers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :vga_cables, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :kettle_leads, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :routers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :lan_switches, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  
  private
    
    # Import Stock Data
    def self.import(file)
      spreadsheet = open_spreadsheet(file)
      
      s_header = Array['id','batch_name','keyboards','mice','monitors','printers','speakers','vga_cables','kettle_leads','routers','lan_switches','staff_id','staff_name','staff_email','created_at','updated_at']
      (2..spreadsheet.sheet(0).last_row).each do |i|
        stock_row = Hash[[s_header, spreadsheet.row(i)].transpose]
        s_row = stock_row.to_hash.except("staff_name","staff_email")
        stock = find_by_id(s_row["id"]) || new
        stock.attributes = s_row.to_hash
        stock.save!
      end
      
      @sent_stocks = SentStock.all
      x_header = Array['id','sent_batch_name','sent_keyboards','sent_mice','sent_monitors','sent_printers','sent_speakers','sent_vga_cables','sent_kettle_leads','sent_routers','sent_lan_switches','staff_id','staff_name','staff_email','created_at','updated_at']
      (2..spreadsheet.sheet(1).last_row).each do |i|
        sent_stock_row = Hash[[x_header, spreadsheet.sheet(1).row(i)].transpose]
        x_row = sent_stock_row.to_hash.except("staff_name","staff_email")
        if @sent_stocks.any? {|sent_stock| sent_stock.id == x_row["id"] }
          sent_stock.attributes = x_row
          sent_stock.save!
        else
          sent_stock = SentStock.create(x_row)
          sent_stock.save!
        end
      end
      
    end
  
    # Open spreadsheet
    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
        when '.csv' then Roo::Spreadsheet.open(file.path, extension: :csv)
        when '.xls' then Roo::Spreadsheet.open(file.path, extension: :xls)
        when '.xlsx' then Roo::Spreadsheet.open(file.path, extension: :xlsx)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end
  
end

