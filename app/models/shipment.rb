class Shipment < ActiveRecord::Base
  belongs_to :computer
  belongs_to :staff
  
  before_save :track_to_id
  
  validates :entertrack, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10000000 }
  validates :staff_id, presence: true
  validates :computer_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :shipped, presence: true, inclusion: { in: [true, false], message: "%{Has the item been shipped?} " } 
  
  private
  
    def track_to_id
      self.computer_id = (entertrack - 10000000)
    end
    
end