class Stock < ActiveRecord::Base
  belongs_to :staff
  
  validates :keyboards, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :mice, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :monitors, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :printers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :speakers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  
end