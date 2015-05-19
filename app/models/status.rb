class Status < ActiveRecord::Base
  belongs_to :computer
  belongs_to :staff
  
  before_save :track_to_id
  
  validates :entertrack, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10000000 }, uniqueness: { message: "There is already a status record for that TuringTrack ID." }
  validates :staff_id, presence: true
  validates :computer_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :scrapped, inclusion: { in: [true, false], message: "%{Has the item been scrapped?}" }
  validates :sold, inclusion: { in: [true, false], message: "%{Has the item been sold?}" }
  validate :scrapped_or_sold
  validate :existing_turingtrack
   
  private
  
    # Converts the input entertrack (probably from barcode scanner) into the computer_id
    def track_to_id
      self.computer_id = (entertrack - 10000000)
    end
    
    # Ensures that a computer's status can only be either scrapped or sold
    def scrapped_or_sold
      if (scrapped.blank? and sold.blank?)
        # Do nothing
      elsif !(scrapped.blank? ^ sold.blank?)
        errors.add(:base, "Please indicate whether a computer has been scrapped or sold, not both.")
      end
    end
    
    # Ensures that statuses can only be made for exisiting computers that don't already have statuses
    def existing_turingtrack
      if !Computer.exists?(:id => (self.entertrack - 10000000))
        errors.add(:base, "Please enter a valid TuringTrack ID.")
      #elsif Status.exists?(:entertrack => self.entertrack)
      #  errors.add(:base, "There is already a status record for that TuringTrack ID.")
      end
    end

end
