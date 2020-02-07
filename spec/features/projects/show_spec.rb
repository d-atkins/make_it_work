require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'from the project show page' do
    it "I can see that project's name, material, and theme" do
      challenge1 = Challenge.create!(theme: "Apartment Furnishings", project_budget: 50)
      project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge: challenge1)

      visit "/projects/#{project1.id}"
      expect(page).to have_content("Litfit")
      expect(page).to have_content("Material: Lamp Shade")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")
    end
  end
end
