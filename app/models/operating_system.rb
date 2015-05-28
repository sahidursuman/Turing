class OperatingSystem < ActiveRecord::Base
  has_many :wipes
  
  validates :os, presence: true, length: { minimum: 2, maximum: 50 }
 
end