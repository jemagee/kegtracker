class Keg < ActiveRecord::Base

  validates :serial_number, presence: true, uniqueness: {message: "This serial number is already in use with another keg."}, format: {with: /\A[0-9]{2}-[0-9]{6}B\z/, message: "Please use a properly formatted serial number"}

  default_scope { where(archive: false)}

  enum status: [:empty, :filled, :priming, :ready, :consigned, :returned]
  
  def destroy
    self.update_attributes(archive: true)
  end
end
