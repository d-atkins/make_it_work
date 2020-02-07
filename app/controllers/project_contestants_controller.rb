class ProjectContestantsController < ApplicationController
  def update
    project = Project.find(params[:project_id])
    contestant = Contestant.where(id: params[:contestant_id])
    project.contestants << contestant
    redirect_back(fallback_location: '/contestants')
  end
end
