class Donor < ActiveRecord::Base
  has_many :computers
  
  validates :donor_name, presence: true, length: {minimum: 5, maximum: 50}
  validates :donor_email, presence: true, length: {minimum: 5, maximum: 50}
  validates :allow_mail, presence: true, inclusion: { in: [true, false], message: "%{Please indicate whether you would like to join our mailing list.} " }
  
  default_scope -> { order(created_at: :desc) }
end