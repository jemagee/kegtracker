class Batch < ActiveRecord::Base
  belongs_to :flavor
  has_many :components, through: :flavor
  before_create :check_batch_eligiblity
  after_create :set_lot, :set_bestby

  validates :gallons, presence: true, numericality: {greater_than_or_equal_to: 10, less_than_or_equal_to: 42}
  validates :flavor_id, presence: true

  enum status: [:pending, :in_progress, :priming, :completed]

  def best_by
    super.strftime("%m/%d/%y")
  end

  private

    def set_lot
      x = Batch.where(flavor_id: flavor_id, created_at: Time.now.midnight..(Time.now.midnight + 1.day)).count - 1
      y = ("A".."Z").to_a[x]
      self.update_attributes(lot: "#{self.flavor.abbreviation}-#{self.created_at.strftime("%m%d%y")}-#{y}")
    end

    def set_bestby
      self.update_attributes(best_by: self.created_at + 120.days)
    end

    def check_batch_eligiblity
      self.flavor.batch_eligible?
    end
end
