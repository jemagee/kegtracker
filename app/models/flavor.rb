class Flavor < ActiveRecord::Base

  validates :name, presence: true, uniqueness: {case_sensitive: false, message: "This flavor name is already in the system"}, format:{with: /\A[a-zA-z\s]{6,}\z/, message: "The flavor name must be at 6 characters (with no numbers)"}
  validates :abbreviation, presence: true, uniqueness: {message: "This abbreviation is already in use"}, format:{with: /\A[A-Z]{4}\z/, message: "The flavor abbreviation MUST BE four letters only"}
 
  def abbreviation=(value)
    write_attribute(:abbreviation, value.upcase)
  end

  def archive
    self.archive = true
  end
  
end
