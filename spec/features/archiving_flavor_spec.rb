require 'rails_helper'

RSpec.feature "Archiving (using delete/destroy) a flavor" do

  let!(:flavor) {FactoryGirl.create(:flavor)}

  scenario "Flavor is archived properly" do

    visit flavors_path
    click_link "Archive Flavor"

    expect(page).to have_content("#{flavor.name} has been successfully archived")
    expect(flavor.archive).to eq true
  end
end
