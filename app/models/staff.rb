class Staff < ActiveRecord::Base
  has_many :staff_types
  has_many :types, through: :staff_types
  has_many :wipes
  has_many :stocks
  has_many :sent_stocks
  accepts_nested_attributes_for :types
  
  before_save { self.staff_email = staff_email.downcase }
  validates :staff_name, presence: true, length: { minimum: 5, maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :staff_email, presence: true, length: { minimum: 3, maximum: 50},
                          uniqueness: { case_sensitive: false },
                          format: { with: VALID_EMAIL_REGEX}
  has_secure_password
end