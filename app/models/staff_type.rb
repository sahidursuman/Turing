class StaffType < ActiveRecord::Base
  belongs_to :staff
  belongs_to :type
end