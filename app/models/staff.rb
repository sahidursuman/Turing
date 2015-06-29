class Staff < ActiveRecord::Base
  has_many :staff_types
  has_many :types, through: :staff_types
  has_many :wipes
  has_many :stocks
  has_many :sent_stocks
  has_many :shipments
  has_many :receipts
  has_many :statuses
  has_many :decommissions
  has_many :arrivals
  accepts_nested_attributes_for :types
  
  before_save { self.staff_email = staff_email.downcase }
  validates :staff_name, presence: true, length: { minimum: 5, maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :staff_email, presence: true, length: { minimum: 3, maximum: 50},
                          uniqueness: { case_sensitive: false },
                          format: { with: VALID_EMAIL_REGEX}
  validates :barcode_pdf_email, allow_blank: true, length: { minimum: 3, maximum: 50},
                          format: { with: VALID_EMAIL_REGEX}
  has_secure_password
end