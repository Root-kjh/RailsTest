def user_data_to_json(user, token)
    return {
        "data": {
            "id": user.id,
            "type": "users",
            "attributes": {
                "token": token,
                "email": user.email,
                "name": "#{user.firstName} #{user.lastName}",
                "country": user.country,
                "createdAt": user.created_at,
                "updatedAt": user.updated_at
            }
        }
    }
end