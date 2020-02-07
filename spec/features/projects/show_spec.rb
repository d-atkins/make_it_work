require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'from the project show page' do
    it "I can see that project's name, material, and theme" do
      c1 = Challenge.create!(theme: "Apartment Furnishings", project_budget: 50)
      p1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge: c1)

      visit "/projects/#{p1.id}"
      expect(page).to have_content("Litfit")
      expect(page).to have_content("Material: Lamp Shade")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")
    end
  end
end
