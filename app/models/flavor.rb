class Flavor < ActiveRecord::Base

  has_many :components
  has_many :ingredients, through: :components

  validates :name, presence: true, uniqueness: {case_sensitive: false, message: "This flavor name is already in the system"}, format:{with: /\A[a-zA-z\s]{6,}\z/, message: "The flavor name must be at least 6 characters (with no numbers)"}
  validates :abbreviation, presence: true, uniqueness: {message: "This abbreviation is already in use"}, format:{with: /\A[A-Z]{4}\z/, message: "The flavor abbreviation MUST BE four letters only"}
  with_options if: Proc.new { |a| !a.gpg.nil?}, on: [:create, :update] do |flavor|
    flavor.validates :gpg, numericality: {message: "The grams per gallon must be a number greater than 60"}
    flavor.validates :gpg, numericality: {greater_than_or_equal_to: 60, message: "The grams per gallon must be at least 60"}
    flavor.validates :gpg, numericality: {less_than_or_equal_to: 500, message: "The grams per gallon must be a number no greater than 500"}

  end

  def abbreviation=(value)
    write_attribute(:abbreviation, value.upcase)
  end

  def destroy
    self.update_attributes(archive: true)
  end
  
end
