require 'rails_helper'


RSpec.describe Project, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

  describe "methods" do
    it "#number_of_contestants" do
      challenge1 = Challenge.create!(theme: "Apartment Furnishings", project_budget: 50)
      project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge: challenge1)
      contestant1 = Contestant.create!(name: "Kentaro Kameyama", age: 32, hometown: "Denver, CO", years_of_experience: 10)
      contestant2 = Contestant.create!(name: "Jay McCarroll", age: 37, hometown: "Austin, TX", years_of_experience: 15)

      project1.contestants << contestant1
      project1.contestants << contestant2

      expect(project1.number_of_contestants).to eq(2)
    end

    it "#average_contestant_experience" do
      challenge1 = Challenge.create!(theme: "Apartment Furnishings", project_budget: 50)
      project1 = Project.create!(name: "Litfit", material: "Lamp Shade", challenge: challenge1)
      contestant1 = Contestant.create!(name: "Kentaro Kameyama", age: 32, hometown: "Denver, CO", years_of_experience: 10)
      contestant2 = Contestant.create!(name: "Jay McCarroll", age: 37, hometown: "Austin, TX", years_of_experience: 15)

      project1.contestants << contestant1
      project1.contestants << contestant2

      expect(project1.average_contestant_experience).to eq(12.5)
    end
  end
end
