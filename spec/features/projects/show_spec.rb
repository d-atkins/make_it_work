require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'from the project show page' do
    it "I can see that project's name, material, theme, contestant count, and average experience" do
      challenge1 = Challenge.create!(theme: "Apartment Furnishings", project_budget: 50)
      project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge: challenge1)
      contestant1 = Contestant.create!(name: "Kentaro Kameyama", age: 32, hometown: "Denver, CO", years_of_experience: 10)
      contestant2 = Contestant.create!(name: "Jay McCarroll", age: 37, hometown: "Austin, TX", years_of_experience: 15)
      contestant3 = Contestant.create!(name: "Ambrose Lau", age: 27, hometown: "San Diego, CA", years_of_experience: 6)

      project1.contestants << [contestant1, contestant2, contestant3]

      visit "/projects/#{project1.id}"

      expect(page).to have_content("Litfit")
      expect(page).to have_content("Material: Lamp Shade")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")
      expect(page).to have_content("Number of Contestants: 3")
      expect(page).to have_content("Average Contestant Experience: 10.33")
    end

    it "I can't see average contestant experience if there are no contestants" do
      challenge1 = Challenge.create!(theme: "Apartment Furnishings", project_budget: 50)
      project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge: challenge1)

      visit "/projects/#{project1.id}"

      expect(page).to have_content("Litfit")
      expect(page).to have_content("Material: Lamp Shade")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")
      expect(page).to have_content("Number of Contestants: 0")
      expect(page).to_not have_content("Average Contestant Experience:")
    end

    it "I can add a contestant to a project" do
      challenge1 = Challenge.create!(theme: "Apartment Furnishings", project_budget: 50)
      project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge: challenge1)
      contestant1 = Contestant.create!(name: "Kentaro Kameyama", age: 32, hometown: "Denver, CO", years_of_experience: 10)
      contestant2 = Contestant.create!(name: "Jay McCarroll", age: 37, hometown: "Austin, TX", years_of_experience: 15)
      contestant3 = Contestant.create!(name: "Ambrose Lau", age: 27, hometown: "San Diego, CA", years_of_experience: 6)
      contestant4 = Contestant.create!(name: "New Guy", age: 12, hometown: "Longmont, CO", years_of_experience: 1)

      project1.contestants << contestant1
      project1.contestants << contestant2
      project1.contestants << contestant3

      visit "/contestants"

      within("#contestant-#{contestant4.id}") do
        expect(page).to_not have_content("Projects: #{project1.name}")
      end

      visit "/projects/#{project1.id}"

      expect(page).to have_content("Number of Contestants: 3")

      fill_in "contestant_id", with: contestant4.id
      click_button "Add Contestant To Project"

      expect(current_path).to eq("/projects/#{project1.id}")
      expect(page).to have_content("Number of Contestants: 4")

      visit "/contestants"

      within("#contestant-#{contestant4.id}") do
        expect(page).to have_content("Projects: #{project1.name}")
      end
    end
  end
end
