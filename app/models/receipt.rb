class Receipt < ActiveRecord::Base
  belongs_to :computer
  belongs_to :staff
  
  before_save :track_to_id
  
  validates :entertrack, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10000000 }, uniqueness: { message: "There is already a receipt record for that TuringTrack ID." }
  validates :staff_id, presence: true
  validates :computer_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :received, inclusion: { in: [true, false], message: "%{Has the item been received?} " } 
  validates :school, length: { minimum: 2, maximum: 150 }, allow_blank: true
  validate :existing_turingtrack
  
  private
  
    def track_to_id
      self.computer_id = (entertrack - 10000000)
    end
    
    # Ensures that receipts can only be made for exisiting computers that don't already have statuses and that have shipment records where shipped is true
    def existing_turingtrack
      if !Computer.exists?(:id => (self.entertrack - 10000000))
        errors.add(:base, "Please enter a valid TuringTrack ID.")
      elsif !Shipment.exists?(:computer_id => (self.entertrack - 10000000), :shipped => true)
        errors.add(:base, "Only computers that have been shipped can be received.")
      end
    end
    
    def self.search(search)
      where("entertrack = ? OR school LIKE ?", search, "%#{search}%")
    end
    
end