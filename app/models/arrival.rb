class Arrival < ActiveRecord::Base
  belongs_to :computer
  belongs_to :staff
  
  before_save :track_to_id
  
  validates :entertrack, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10000000 }, uniqueness: { message: "There is already an arrival record for that TuringTrack ID." }
  validates :staff_id, presence: true
  validates :computer_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :arrived, inclusion: { in: [true, false], message: "%{Has the item arrived at the hub?}" } 
  validate :existing_turingtrack
  
  private
  
    def track_to_id
      self.computer_id = (entertrack - 10000000)
    end
    
    # Ensures that arrivals can only be made for exisiting computers 
    def existing_turingtrack
      begin
        if !Computer.exists?(:id => (self.entertrack - 10000000))
          errors.add(:base, "Please enter a valid TuringTrack ID.")
        end
      rescue NoMethodError
      end
    end
    
    def self.search(search)
      where("entertrack = ?", search)
    end
    
end