class Hub < ActiveRecord::Base
  has_many :computers
  
  validates :hub_location, presence: true, length: { minimum: 2, maximum: 200 }
 
end