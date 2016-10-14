require 'rails_helper'

RSpec.feature "Deleting a Keg" do

  let(:keg) { FactoryGirl.create(:keg) }
  let!(:kegg) { FactoryGirl.create(:keg) }

  scenario "Deleting keg works" do

    visit keg_path(keg)
    click_link "Retire Keg"
    keg.reload

    expect(page).to have_content("The keg was retired")
    expect(keg.retired?).to eq true
    expect(page).to_not have_content(keg.serial_number)
    expect(page).to have_content(kegg.serial_number)
    expect(current_path).to  eq (kegs_path)
  end
end