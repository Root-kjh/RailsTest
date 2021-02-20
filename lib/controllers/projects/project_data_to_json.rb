def project_data_to_json(project, owner_name)
    return {
        "data": {
            "id": project['id'],
            "type": "project",
            "attributes": {
                "title": project.title,
                "thumbnail": project.thumbnail.url,
                "description": project.description,
                "location": project.location,
                "type": project_type_to_string(project.projectType),
                "ownerName": owner_name,
                "createdAt": project.created_at,
                "updatedAt": project.updated_at
            }
        }
    }
end

def project_list_data_to_json(project_list)
    project_list_json = Array.new
    project_list.each do |project|
        user = User.find_by_id(project.user_id)
        project_json_data = {
            "id": project['id'],
            "type": "project",
            "attributes": {
                "title": project.title,
                "thumbnail": project.thumbnail.url,
                "description": project.description,
                "location": project.location,
                "type": project_type_to_string(project.projectType),
                "ownerName": "#{user.firstName} #{user.lastName}",
                "createdAt": project.created_at,
                "updatedAt": project.updated_at
            }
        }
        project_list_json.push(project_json_data)
    end
    return {"data": project_list_json}
end

private

def project_type_to_string(type)
    if type == 0
        return "in_house"
    elsif type == 1
        return "external"
    else
        return "international"
    end
end