class Api::V1::ProjectsController < ActionController::API
    include Knock::Authenticable
    before_action :authenticate_user, except: [:getAllProjects, :getProject]
    before_action :get_current_user_name, only: [:createProject, :updateProject]
    skip_before_action :verify_authenticity_token, raise: false
    
    require 'open-uri'
    require './lib/controllers/projects/project_data_to_json'
    require 'mimemagic'

    def createProject
        type_to_int
        project = Project.new(projects_params)
        if params[:thumbnail].present? and not is_image(params[:thumbnail])
            render(json: {"message": "not image file"}, status: :bad_request)
        else
            project.user_id = current_user.id
            if project.save
                render(json: project_data_to_json(project, @current_user_name), status: :created)
            else
                render(json: project.errors, status: :bad_request)
            end
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
            render(json: {"message": "project not found"}, status: :bad_request)
        end
    end

    def updateProject
        type_to_int
        project = Project.where(user_id: current_user.id, id: params[:id]).first
        if project.present?
            project.title = params[:title]
            project.description = params[:description]
            project.projectType = params[:projectType]
            project.location = params[:location]
            if params[:thumbnail].present?
                thumbnail = open(params[:thumbnail])
                if thumbnail.present? and is_image(thumbnail)
                    project.thumbnail = thumbnail
                else
                    render(json: {"message": "not image file"}, status: :bad_request)
                end
            end

            if project.save
                render(json: project_data_to_json(project, @current_user_name), status: :created)
            else
                render(json: project.errors, status: :bad_request)
            end
        else
            render(json: {"message": "project not found"}, status: :bad_request)
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

    def is_image(file)
        file_type = MimeMagic.by_magic(file).type
        return file_type.include? "image"
    end

    def get_current_user_name
        @current_user_name = get_owner_name(current_user.id)
    end

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
