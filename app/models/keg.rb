class Keg < ActiveRecord::Base

  validates :serial_number, presence: true, uniqueness: true
end
