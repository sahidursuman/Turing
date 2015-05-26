class Computer < ActiveRecord::Base
  belongs_to :donor
  belongs_to :hub
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
      where("turingtrack = ? OR serial_no LIKE ? OR manufacturer LIKE ? 
      Or product_key LIKE ?", search, "%#{search}%", "%#{search}%", "%#{search}%")
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