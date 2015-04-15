class Type < ActiveRecord::Base
  validates :department, presence: true, length: { minimum: 2, maximum: 25 }
  has_many :staff_types
  has_many :staffs, through: :staff_types
end