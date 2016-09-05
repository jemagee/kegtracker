class Component < ActiveRecord::Base
  belongs_to :flavor
  belongs_to :ingredient

  validates :percentage, presence: true, numericality: {less_than_or_equal_to: 100}
end
