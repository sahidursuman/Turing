class Type < ActiveRecord::Base
  has_many :staff_types
  has_many :staffs, through: :staff_types
  
  validates :department, presence: true, length: { minimum: 2, maximum: 25 }

end