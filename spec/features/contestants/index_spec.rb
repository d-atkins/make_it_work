require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'from the contestants index page' do
    it "I can see a list of names of all the contestants and their projects" do
      challenge1 = Challenge.create!(theme: "Apartment Furnishings", project_budget: 50)
      challenge2 = Challenge.create!(theme: "Dumb Stuff", project_budget: 51)
      project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge: challenge1)
      project2 = Project.create!(name: "Rug Tuxedo", material: "Rug", challenge: challenge2)
      project3 = Project.create!(name: "LeatherFeather", material: "Leather", challenge: challenge2)
      contestant1 = Contestant.create!(name: "Kentaro Kameyama", age: 32, hometown: "Denver, CO", years_of_experience: 10)
      contestant2 = Contestant.create!(name: "Jay McCarroll", age: 37, hometown: "Austin, TX", years_of_experience: 15)

      contestant1.projects << [project1, project2]
      contestant2.projects << project3

      visit '/contestants'

      within("#contestant-#{contestant1.id}") do
        expect(page).to have_content(contestant1.name)
        expect(page).to have_content("Projects: #{project1.name}, #{project2.name}")
        expect(page).to_not have_content(contestant2.name)
        expect(page).to_not have_content(project3.name)
      end

      within("#contestant-#{contestant2.id}") do
        expect(page).to have_content(contestant2.name)
        expect(page).to have_content("Projects: #{project3.name}")
        expect(page).to_not have_content(contestant1.name)
        expect(page).to_not have_content(project1.name)
        expect(page).to_not have_content(project2.name)
      end
    end
  end
end
