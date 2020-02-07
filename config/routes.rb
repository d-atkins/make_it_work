Rails.application.routes.draw do
  get '/projects/:project_id', to: 'projects#show'
  patch '/projects/:project_id', to: 'project_contestants#update'

  get '/contestants', to: 'contestants#index'
end
