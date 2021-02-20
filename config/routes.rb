Rails.application.routes.draw do
  get 'uploader/Thumbnail'

  namespace :api do
    namespace :v1 do
      
      # users View
      post    "/users/signup",  to: "users#signup"
      post    "/auth/signin",   to: "user_token#create"

      # # projects View
      post    "/projects",              to: "projects#createPost"
      get     "/projects",              to: "projects#getAllProjects"
      get     "/projects/my_projects",  to: "projects#getAllOwnedProjects"
      get     "/projects/:id",          to: "projects#getProject"
      put     "/projects/:id",        to: "projects#updateProject"
      delete  "/projects/:id",        to: "projects#deleteProjects"

      # # contents View
      # post    "/projects/:project_id/contents",      to: "contents#createContent"
      # get     "/projects/:project_id/contents",      to: "contents#getContents"
      # get     "/projects/:project_id/contents/:id",  to: "contents#getSpecificContent"
      # put     "/contents/:id",                       to: "contents#updateContent"
      # delete  "/contents/:id",                       to: "contents#deleteContent"

    end
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end