class Wipe < ActiveRecord::Base
  validates :date_wiped, presence: true, length: { is: 10}
  validates :wiped_using, presence: true, length: { minimum: 2, maximum: 50 }
  validates :wiped_by, presence: true, length: { minimum: 2, maximum: 50 }
  has_many :computer_wipes
  has_many :computers, through: :computer_wipes
end