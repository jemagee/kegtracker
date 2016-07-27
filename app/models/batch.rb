class Batch < ActiveRecord::Base
  belongs_to :flavor
  after_create :set_lot

  validates :gallons, presence: true, numericality: {greater_than_or_equal_to: 10, less_than_or_equal_to: 42}

  private

    def set_lot
      x = Batch.where(flavor_id: flavor_id, created_at: Time.now.midnight..(Time.now.midnight + 1.day)).count - 1
      y = ("A".."Z").to_a[x]
      self.update_attributes(lot: "#{self.flavor.abbreviation}-#{self.created_at.strftime("%m%d%y")}-#{y}")
    end
end
