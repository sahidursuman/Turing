class SentStock < ActiveRecord::Base
  belongs_to :staff
  
  validates :sent_keyboards, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :sent_mice, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :sent_monitors, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :sent_printers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :sent_speakers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :sent_vga_cables, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :sent_kettle_leads, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :sent_routers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :sent_lan_switches, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  
end