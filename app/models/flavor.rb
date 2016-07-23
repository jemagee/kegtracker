class Flavor < ActiveRecord::Base

  validates :name, presence: true, uniqueness: {case_sensitive: false, message: "This flavor name is already in the system"}, format:{with: /\A[a-zA-z\s]{6,}\z/, message: "The flavor name must be at least 6 characters (with no numbers)"}
  validates :abbreviation, presence: true, uniqueness: {message: "This abbreviation is already in use"}, format:{with: /\A[A-Z]{4}\z/, message: "The flavor abbreviation MUST BE four letters only"}
  with_options if: Proc.new { |a| !a.gpg.nil?}, on: [:create, :update] do |flavor|
    flavor.validates :gpg, numericality: {greater_than_or_equal_to: 100, message: "The grams per gallons must be at least 100 grams" }
  end

  def abbreviation=(value)
    write_attribute(:abbreviation, value.upcase)
  end

  def destroy
    self.update_attributes(active: true)
  end
  
end
