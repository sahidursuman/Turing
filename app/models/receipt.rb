class Receipt < ActiveRecord::Base
  belongs_to :computer
  belongs_to :staff
  
  before_save :track_to_id
  
  validates :entertrack, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10000000 }
  validates :staff_id, presence: true
  validates :computer_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :received, presence: true, inclusion: { in: [true, false], message: "%{Has the item been received?} " } 
  validates :school, length: { minimum: 2, maximum: 150 }, allow_blank: true
  
  private
  
    def track_to_id
      self.computer_id = (entertrack - 10000000)
    end
    
end