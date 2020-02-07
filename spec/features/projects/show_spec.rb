require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'from the project show page' do
    it "I can see that project's name, material, theme, and contestant count" do
      challenge1 = Challenge.create!(theme: "Apartment Furnishings", project_budget: 50)
      project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge: challenge1)
      contestant1 = Contestant.create(name: "Kentaro Kameyama", age: 32, hometown: "Denver, CO", years_of_experience: 10)
      contestant2 = Contestant.create(name: "Jay McCarroll", age: 37, hometown: "Austin, TX", years_of_experience: 15)
      contestant3 = Contestant.create(name: "Ambrose Lau", age: 27, hometown: "San Diego, CA", years_of_experience: 6)

      project1.contestants << contestant1
      project1.contestants << contestant2
      project1.contestants << contestant3

      visit "/projects/#{project1.id}"
      expect(page).to have_content("Litfit")
      expect(page).to have_content("Material: Lamp Shade")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")
      expect(page).to have_content("Number of Contestants: #{project1.number_of_contestants}")
    end
  end
end
