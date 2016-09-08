class Component < ActiveRecord::Base
  belongs_to :flavor
  belongs_to :ingredient

  validates :percentage, presence: true, numericality: {less_than_or_equal_to: 100}
  validates :ingredient_id, uniqueness: {scope: :flavor, message: "This ingredient is already part of the flavor recipe"}
  validate :flavor_components_sum_can_not_exceed_one_hundred

  def flavor_components_sum_can_not_exceed_one_hundred
  	if !self.percentage.nil?
  		if self.percentage + self.flavor.components.sum('percentage') > 100
  			errors.add(:percentage) << "The total of all a flavors components can not exceed 100 percent"
  		end
  	end
  end
end

