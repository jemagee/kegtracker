class Ingredient < ActiveRecord::Base

  validates :name, presence: true, uniqueness: { case_sensitive: false, message: "This ingredient is already in the database" }, length: { minimum: 4 }
end
