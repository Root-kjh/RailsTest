def content_data_to_json(content, owner_name)
    return {
        "data": {
              "id": content['id'],
              "type": "content",
              "attributes": {
                  "projectId": content['project_id'],
                  "projectOwnerName": owner_name,
                  "title": content['title'],
                  "body": content['body'],
                  "createdAt": content['created_at'],
                  "updatedAt": content['created_at']
            }
          }
      }
end

def content_list_data_to_json(content_list)
    content_list_json = Array.new
    content_list.each do |content|
        user = User.find_by_id(content.user_id)
        content_json_data = {
            "id": content['id'],
            "type": "content",
            "attributes": {
                "projectId": content['project_id'],
                "projectOwnerName": "#{user['firstName']} #{user['lastName']}",
                "title": content['title'],
                "body": content['body'],
                "createdAt": content['created_at'],
                "updatedAt": content['created_at']
          }
        }
        content_list_json.push(content_json_data)
    end
    return {"data": content_list_json}
end