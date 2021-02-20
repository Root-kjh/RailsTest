Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      
      # users View
      post    "/users/signup",  to: "users#signup"
      post    "/auth/signin",   to: "user_token#create"

      # # projects View
      get     "/projects/my_projects",  to: "projects#getAllOwnedProjects"
      get     "/projects/:id",          to: "projects#getProject"
      put     "/projects/:id",        to: "projects#updateProject"
      delete  "/projects/:id",        to: "projects#deleteProjects"
      post    "/projects",              to: "projects#createProject"
      get     "/projects",              to: "projects#getAllProjects"

      # contents View
      get     "/projects/:project_id/contents/:id",  to: "contents#getSpecificContent"
      post    "/projects/:project_id/contents",      to: "contents#createContent"
      get     "/projects/:project_id/contents",      to: "contents#getContents"
      put     "/contents/:id",                       to: "contents#updateContent"
      delete  "/contents/:id",                       to: "contents#deleteContent"

    end
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end