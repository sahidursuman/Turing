class Computer < ActiveRecord::Base
  belongs_to :staff
  validates :staff_id, presence: true
  validates :manufacturer, length: { minimum: 5, maximum: 50 }
  validates :computer_type, presence: true, length: { minimum: 2, maximum: 50 }
  validates :model_no, length: { minimum: 5, maximum: 50 }
  validates :serial_no, presence: true, length: { minimum: 5, maximum: 50 }
  validates :date, length: { is: 10 }
  validates :action_taken, length: { minimum: 5, maximum: 250 }
  validates :donor, length: { minimum: 5, maximum: 50 }
  validates :specification, length: { minimum: 5, maximum: 250 }
  validates :product_key, length: { minimum: 5, maximum: 50 }
  validates :initials_flag, inclusion: { in: %w(y n) }, length: { is: 1 }
# %w(foo bar) is a shortcut for ["foo", "bar"]
end