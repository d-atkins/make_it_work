class Project <ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def number_of_contestants
    contestants.count
  end

  def average_contestant_experience
    contestants.sum(:years_of_experience).to_f / number_of_contestants
  end
end
