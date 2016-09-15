class Ingredient < ActiveRecord::Base

	has_many :components
	has_many :flavors, through: :components

  validates :name, presence: true, uniqueness: { case_sensitive: false, message: "This ingredient is already in the database" }, length: { minimum: 4 }

  def destroy
  	if self.flavors.any?
  		self.update(archived: true)
  	else
  		super
  	end
  end
end
