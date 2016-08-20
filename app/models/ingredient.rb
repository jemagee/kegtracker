class Ingredient < ActiveRecord::Base

  validates :name, uniqueness: { case_sensitive: false, message: "This ingredient is already in the database" }
end
