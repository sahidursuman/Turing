class Shipment < ActiveRecord::Base
  belongs_to :computer
  belongs_to :staff
  
  before_save :track_to_id
  
  validates :entertrack, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10000000 }, uniqueness: { message: "There is already a shipment record for that TuringTrack ID." }
  validates :staff_id, presence: true
  validates :computer_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :shipped, inclusion: { in: [true, false], message: "%{Has the item been shipped?} " } 
  validate :existing_turingtrack

  private
  
    def track_to_id
      self.computer_id = (entertrack - 10000000)
    end
    
    # Ensures that shipments can only be made for exisiting computers that don't already have statuses
    def existing_turingtrack
      begin
        if !Computer.exists?(:id => (self.entertrack - 10000000))
          errors.add(:base, "Please enter a valid TuringTrack ID.")
        #elsif !Wipe.exists?(:computer_id => (self.entertrack - 10000000))
        elsif !Wipe.exists?(['computer_id = ? AND length(action_taken) > ?', (self.entertrack - 10000000), 0])
          errors.add(:base, "Only computers that have been wiped can be shipped.")
        end
      rescue NoMethodError
      end
    end
    
    def self.search(search)
      where("entertrack = ?", search)
    end
    
end