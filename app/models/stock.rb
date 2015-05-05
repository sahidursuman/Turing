class Stock < ActiveRecord::Base
  
  validates :keyboards, numericality: { only_integer: true }, allow_blank: true
  validates :mice, numericality: { only_integer: true }, allow_blank: true
  validates :monitors, numericality: { only_integer: true }, allow_blank: true
  validates :printers, numericality: { only_integer: true }, allow_blank: true
  validates :speakers, numericality: { only_integer: true }, allow_blank: true
  
end