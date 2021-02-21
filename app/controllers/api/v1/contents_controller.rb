class Api::V1::ContentsController < ActionController::API
    include Knock::Authenticable
    before_action :authenticate_user, except: [:getContents, :getSpecificContent]
    before_action :get_current_user_name, only: [:createContent, :updateContent]
    skip_before_action :verify_authenticity_token, raise: false
    
    require './lib/controllers/contents/content_data_to_json'

    def createContent
        content = Content.new(content_params)
        content.user_id = current_user.id
        content.project_id = params[:project_id]
        if content.save
            render(json: content_data_to_json(content, @current_user_name), status: :created)
        else
            render(json content.errors status: :bad_request)
        end
    end

    def getContents
        if Project.find_by_id(params[:project_id]).present?
            content_list = Content.where(project_id: params[:project_id])
            render(json: content_list_data_to_json(content_list))
        else
            render(json: {"message": "project not found"}, status: :bad_request)
        end
    end

    def getSpecificContent
        content = Content.where(project_id: params[:project_id], id: params[:id]).first
        if content.present?
            owner_name = get_owner_name(content.user_id)
            render(json: content_data_to_json(content, owner_name))
        else
            render(json: {"message": "content not found"}, status: :bad_request)
        end
    end

    def updateContent
        content = Content.where(id: params[:id], user_id: current_user.id).first
        if content.present?
            if content.update(content_params)
                render(json: content_data_to_json(content, @current_user_name))
            else
                render(json: content.error, status: :bad_request)
            end
        else
            render(json: {"message": "content not found"}, status: :bad_request)
        end

    end

    def deleteContent
        content = Content.where(id: params[:id], user_id: current_user.id).first
        if content.present?
            content.delete
            render(json: {"message": "Deleted"})
        else
            render(json: {"message": "content not found"}, status: :bad_request)
        end
    end

    private

    def content_params
        params.permit(:title, :body)
    end

    def get_current_user_name
        @current_user_name = get_owner_name(current_user.id)
    end

    def get_owner_name(user_id)
        user = User.find_by_id(user_id)
        return "#{user.firstName} #{user.lastName}"
    end
end
