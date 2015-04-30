class Wipe < ActiveRecord::Base
  belongs_to :computer#, dependent: destroy
  belongs_to :staff
  
  validates :staff_id, presence: true
  #validates :computer_id, presence: true
  validates :action_taken, presence: true, length: { minimum: 2, maximum: 250 }
end