class Keg < ActiveRecord::Base

  validates :serial_number, presence: true, uniqueness: true, format: {with: /\A[0-9]{2}-[0-9]{6}B\z/, message: "Please use a properly formatted serial number"}

end
