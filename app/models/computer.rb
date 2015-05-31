class Computer < ActiveRecord::Base
  belongs_to :donor
  belongs_to :hub
  has_one :arrival, dependent: :destroy
  has_one :shipment, dependent: :destroy
  has_one :receipt, dependent: :destroy
  has_one :status, dependent: :destroy
  has_one :wipe, dependent: :destroy
  has_one :decommission, dependent: :destroy
  
  accepts_nested_attributes_for :wipe
  accepts_nested_attributes_for :donor#, allow_destroy: true
  # alloy_destroy: true does not automatically delete associated records, but rather allows allows users to delete them. If the 
  # hash of attributes for an object contains the key _destroy with a value of 1 or true then the object will be destroyed.
  
  after_create :id_to_track
  
  validates :manufacturer, presence: true, length: { minimum: 2, maximum: 50 }
  validates :computer_type, presence: true, length: { minimum: 2, maximum: 50 }
  validates :specification, length: { minimum: 2, maximum: 250 }, allow_blank: true
  validates :model_no, length: { minimum: 2, maximum: 50 }, allow_blank: true
  validates :serial_no, length: { minimum: 2, maximum: 50 }, allow_blank: true 
  validates :product_key, length: { minimum: 2, maximum: 50 }, allow_blank: true
  #validates :turingtrack, length: { is: 8 }, allow_blank: true

  default_scope -> { order(updated_at: :desc) }
  mount_uploader :picture, PictureUploader
# %w(foo bar) is a shortcut for ["foo", "bar"], e.g. validates :initials_flag, inclusion: { in: %w(y n) }, length: { is: 1 }
  
  private
  
    def self.search(search)
      where("turingtrack = ? OR lower(serial_no) LIKE ? OR lower(manufacturer) LIKE ? 
      Or lower(product_key) LIKE ?", search, "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%")
    end
  
    def id_to_track
      self.turingtrack = (id.to_i + 10000000).to_s
      self.save
    end
  
    def picture_size
      if picture_size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    
    ############################### Database reset upload ################################
    def self.import(file)
      spreadsheet = open_spreadsheet(file)
      #header = spreadsheet.row(1)
      #h = "'#{header.join("','")}'"
      c_header = Array['id','turingtrack','manufacturer','computer_type','model_no','serial_no','product_key','specification','created_at','updated_at','hub_id','donor_id']
      d_header = Array['id','donor_name','donor_email','allow_mail','donor_address','paper_cert','created_at','updated_at']
      a_header = Array['id','arrived','staff_id','staff_name','staff_email','created_at','updated_at']
      s_header = Array['id','has_status','scrapped','sold','customer','price','staff_id','staff_name','staff_email','created_at','updated_at']
      w_header = Array['operating_system_id','id','has_wipe','staff_id','staff_name','staff_email','action_taken','created_at','updated_at']
      o_header = Array['os','id']
      sh_header = Array['id','shipped','staff_id','staff_name','staff_email','created_at','updated_at']
      r_header = Array['id','received','school','staff_id','staff_name','staff_email','created_at','updated_at']
      de_header = Array['id','decommissioned','staff_id','staff_name','staff_email','created_at','updated_at']
      (2..spreadsheet.last_row).each do |i|
        computer_row = Hash[[c_header, spreadsheet.row(i)[0..11]].transpose]
        computer = find_by_id(computer_row["id"]) || new
        computer.attributes = computer_row.to_hash
        #computer.specification = h
        computer.save!
        
        @donors = Donor.all
        donor_row = Hash[[d_header, spreadsheet.row(i)[11..18]].transpose]
        if @donors.any? {|donor| donor.id == donor_row["id"] }
          computer.donor.attributes = donor_row.to_hash
          computer.save!
        else
          donor = Donor.create(donor_row.to_hash)
          donor.save!
        end
        
        @arrivals = Arrival.all
        arrival_row = Hash[[a_header, spreadsheet.row(i)[21..27]].transpose]
        a_row = arrival_row.to_hash.except("staff_name","staff_email")
        a_row[:computer_id] = computer.id
        a_row[:entertrack] = (computer.id + 10000000)
        if @arrivals.any? {|arrival| arrival.id == a_row["id"] }
          computer.arrival.attributes = a_row
          computer.save!
        else
          if a_row["id"] != 0
            arrival = Arrival.create(a_row)
            arrival.save!
          end
        end
        
        @statuses = Status.all
        status_row = Hash[[s_header, spreadsheet.row(i)[28..38]].transpose]
        s_row = status_row.to_hash.except("has_status","staff_name","staff_email")
        s_row[:computer_id] = computer.id
        s_row[:entertrack] = (computer.id + 10000000)
        if @statuses.any? {|status| status.id == status_row["id"] }
          computer.status.attributes = s_row
          computer.save!
        else
          unless s_row["id"] == 0
            status = Status.create(s_row)
            status.save!
          end
        end
        
        @wipes = Wipe.all
        wipe_row = Hash[[w_header, spreadsheet.row(i)[40..48]].transpose]
        w_row = wipe_row.to_hash.except("has_wipe","staff_name","staff_email")
        w_row[:computer_id] = computer.id
        if @wipes.any? {|wipe| wipe.id == wipe_row["id"] }
          computer.wipe.attributes = w_row
          computer.save!
        else
          wipe = Wipe.create(w_row)
          wipe.save!
        end
        
        @operating_systems = OperatingSystem.all
        oper_row = Hash[[o_header, spreadsheet.row(i)[39..40]].transpose]
        o_row = oper_row.to_hash
        if @operating_systems.any? {|oper| oper.id == o_row["id"] }
          computer.wipe.operating_system.attributes = o_row
          computer.save!
        else
          if o_row["id"] != 0
            oper = OperatingSystem.create(o_row)
            oper.save!
          end
        end
        
        @shipments = Shipment.all
        shipment_row = Hash[[sh_header, spreadsheet.row(i)[49..55]].transpose]
        sh_row = shipment_row.to_hash.except("staff_name","staff_email")
        sh_row[:computer_id] = computer.id
        sh_row[:entertrack] = (computer.id + 10000000)
        if @shipments.any? {|shipment| shipment.id == shipment_row["id"] }
          computer.shipment.attributes = sh_row
          computer.save!
        else
          if computer.wipe.action_taken.length > 0 and sh_row["id"] != 0
            shipment = Shipment.create(sh_row)
            shipment.save!
          end
        end
        
        @receipts = Receipt.all
        receipt_row = Hash[[r_header, spreadsheet.row(i)[56..63]].transpose]
        r_row = receipt_row.to_hash.except("staff_name","staff_email")
        r_row[:computer_id] = computer.id
        r_row[:entertrack] = (computer.id + 10000000)
        if @receipts.any? {|receipt| receipt.id == receipt_row["id"] }
          computer.receipt.attributes = r_row
          computer.save!
        else
          if computer.shipment and computer.shipment.shipped and r_row["id"] != 0
            receipt = Receipt.create(r_row)
            receipt.save!
          end
        end
        
        @decommissions = Decommission.all
        decommission_row = Hash[[de_header, spreadsheet.row(i)[64..70]].transpose]
        de_row = decommission_row.to_hash.except("staff_name","staff_email")
        de_row[:computer_id] = computer.id
        de_row[:entertrack] = (computer.id + 10000000)
        if @decommissions.any? {|decommission| decommission.id == decommission_row["id"] }
          computer.decommission.attributes = de_row
          computer.save!
        else
          if computer.receipt and computer.receipt.received and de_row["id"] != 0
            decommission = Decommission.create(de_row)
            decommission.save!
          end
        end
      
      end
    end
    #####################################################################################################
    
    # Open spreadsheet
    def self.open_spreadsheet(file)
        case File.extname(file.original_filename)
          when '.csv' then Roo::Spreadsheet.open(file.path, extension: :csv)
          when '.xls' then Roo::Spreadsheet.open(file.path, extension: :xls)
          when '.xlsx' then Roo::Spreadsheet.open(file.path, extension: :xlsx)
        else raise "Unknown file type: #{file.original_filename}"
        end
    end
    
#   Function to output computer table to CSV (without view template)  
#    def self.to_csv(options = {})
#      CSV.generate(options) do |csv|
#        csv << column_names
#        all.each do |computer|
#          csv << computer.attributes.values_at(*column_names)
#        end
#      end
#    end

end 