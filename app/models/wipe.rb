class Wipe < ActiveRecord::Base
  belongs_to :computer#, dependent: destroy
  belongs_to :staff
  
  validates :staff_id, presence: true
  validates :computer_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :action_taken, presence: true, length: { minimum: 2, maximum: 250 }, allow_blank: true

end