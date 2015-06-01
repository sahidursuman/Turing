class Hub < ActiveRecord::Base
  has_many :computers
  
  validates :hub_location, presence: true, length: { minimum: 2, maximum: 150 }
  validates :hub_fao, presence: true, length: { minimum: 2, maximum: 100 }
 
end