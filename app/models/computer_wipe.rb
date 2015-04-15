class ComputerWipe < ActiveRecord::Base
  belongs_to :computer
  belongs_to :wipe
end