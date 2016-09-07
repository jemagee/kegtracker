class Component < ActiveRecord::Base
  belongs_to :flavor
  belongs_to :ingredient

  validates :percentage, presence: true, numericality: {less_than_or_equal_to: 100}
  validates :ingredient_id, uniqueness: {scope: :flavor, message: "This ingredient is already part of the flavor recipe"}
end
