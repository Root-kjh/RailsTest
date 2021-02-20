class Api::V1::ProjectsController < ActionController::API
    include Knock::Authenticable
    before_action :authenticate_user, except: [:getAllProjects, :getProject]
    skip_before_action :verify_authenticity_token, raise: false
    
    require './lib/controllers/projects/project_data_to_json'
    
    def createPost
        type_to_int
        project = Project.new(projects_params)
        project.user_id = current_user.id

        if project.save
            render(json: project_data_to_json(project, get_owner_name(current_user.id)), status: :created)
        else
            render(json: project.errors, status: :bad_request)
        end
    end

    def getAllProjects
        render(json: project_list_data_to_json(Project.all))
    end

    def getAllOwnedProjects
        owned_project_list = Project.where(user_id: current_user.id)
        render(json: project_list_data_to_json(owned_project_list))
    end

    def getProject
        project = Project.find_by_id(params[:id])
        if project
            render(json: project_data_to_json(project, get_owner_name(project.user_id)))
        else
            render(json: project.errors, status: :bad_request)
        end
    end

    def updateProject
        type_to_int
        project = Project.where(user_id: current_user.id, id: params[:id]).first
        project.title = params[:title]
        project.description = params[:description]
        project.projectType = params[:projectType]
        project.location = params[:location]
        puts(params[:thumbnail])
        project.thumbnail = params[:thumbnail]

        if project.save
            render(json: project_data_to_json(project, get_owner_name(current_user.id)), status: :created)
        else
            render(json: project.errors, status: :bad_request)
        end
    end

    def deleteProjects
        project = Project.where(user_id: current_user.id, id: params[:id]).first
        if project.present?
            project.delete
            render(json: {"message": "Deleted"})
        else
            render(json: {"message": "project not found"}, status: :bad_request)
        end
    end

    private

    def get_owner_name(user_id)
        user = User.find_by_id(user_id)
        return "#{user.firstName} #{user.lastName}"
    end

    def projects_params
        params.permit(:title, :description, :projectType, :location, :thumbnail)
    end

    def type_to_int()
        if params['type'].present?
            if params['type'] == "in_house"
                type = 0
            elsif params['type'] == "external"
                type = 1
            else
                type = 2
            end
            params.delete :type
            params.merge!({:projectType => type})
        end
    end
end
