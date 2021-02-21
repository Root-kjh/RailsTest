require "test_helper"

class ProjectFlowTest < ActionDispatch::IntegrationTest
  def setup
    post "/api/v1/auth/signin",
      params: {:auth => {:email => users(:one).email, :password => "test_one" }}
    assert_equal 200, status
    response_body = JSON.parse(@response.body)
    @jwt = response_body['data']['attributes']['token']
    @owner_name = "#{users(:one).firstName} #{users(:one).lastName}"
    @thumbnail = fixture_file_upload(Rails.root.join("test/fixtures/files/test_image.png"), 'image/png')
    @update_data = {
      "title" => "updated title",
      "thumbnail" => @thumbnail,
      "description" => "updated project",
      "location" => "busan",
      "type" => "international"
    }
  end

  test "create project" do
    post "/api/v1/projects",
      params: {title: "test", description: "test project", type: "international", location: "seoul", thumbnail: @thumbnail},
      headers: {"Authorization" => "Bearer "+@jwt}
    assert_equal 201, status
    response_body = JSON.parse(@response.body)

    finded_project = Project.find_by(user_id: users(:one).id, title: "test")

    assert_equal response_body['data']['type'], "project"
    assert_equal response_body['data']['attributes']['title'], "test"
    assert_equal response_body['data']['attributes']['description'], "test project"
    assert_equal response_body['data']['attributes']['type'], "international"
    assert_equal response_body['data']['attributes']['location'], "seoul"
    assert_equal response_body['data']['attributes']['ownerName'], @owner_name
    assert_equal response_body['data']['attributes']['thumbnail'], finded_project.thumbnail.url
    assert response_body['data']['attributes']['createdAt'].present?
    assert response_body['data']['attributes']['updatedAt'].present?
  end

  test "create project request invalid" do
    post "/api/v1/projects",
    params: {title: "", description: "test project", type: "", location: "", thumbnail: @thumbnail},
    headers: {"Authorization" => "Bearer "+@jwt}
    assert_equal 400, status
  end

  test "create project with no jwt" do
    post "/api/v1/projects",
      params: {title: "test", description: "test project", type: "international", location: "seoul", thumbnail: @thumbnail}
    assert_equal 401, status
  end

  test "get project" do
    get "/api/v1/projects/#{projects(:one).id}"
    assert_equal 200, status
    response_body = JSON.parse(@response.body)
    assert_equal response_body['data']['type'], "project"
    assert_equal response_body['data']['attributes']['title'], projects(:one).title
    assert_equal response_body['data']['attributes']['description'], projects(:one).description
    assert_equal response_body['data']['attributes']['type'], "in_house"
    assert_equal response_body['data']['attributes']['ownerName'], @owner_name
    assert_equal response_body['data']['attributes']['location'], projects(:one).location
    assert_equal response_body['data']['attributes']['thumbnail'], projects(:one).thumbnail.url
    assert response_body['data']['attributes']['createdAt'].present?
    assert response_body['data']['attributes']['updatedAt'].present?
  end

  test "get project not found" do
    get "/api/v1/projects/-1"
    assert_equal 400, status
  end

  test "get all projects" do
    get "/api/v1/projects/"
    assert_equal 200, status
    response_body = JSON.parse(@response.body)

    assert_equal response_body['data'][0]['type'], "project"
    assert_equal response_body['data'][0]['attributes']['title'], projects(:two).title
    assert_equal response_body['data'][0]['attributes']['description'], projects(:two).description
    assert_equal response_body['data'][0]['attributes']['type'], "in_house"
    assert_equal response_body['data'][0]['attributes']['ownerName'], "#{users(:two).firstName} #{users(:two).lastName}" 
    assert_equal response_body['data'][0]['attributes']['location'], projects(:two).location
    assert_equal response_body['data'][0]['attributes']['thumbnail'], projects(:two).thumbnail.url
    assert response_body['data'][0]['attributes']['createdAt'].present?
    assert response_body['data'][0]['attributes']['updatedAt'].present?

    assert_equal response_body['data'][1]['type'], "project"
    assert_equal response_body['data'][1]['attributes']['title'], projects(:one).title
    assert_equal response_body['data'][1]['attributes']['description'], projects(:one).description
    assert_equal response_body['data'][1]['attributes']['type'], "in_house"
    assert_equal response_body['data'][1]['attributes']['ownerName'], @owner_name
    assert_equal response_body['data'][1]['attributes']['location'], projects(:one).location
    assert_equal response_body['data'][1]['attributes']['thumbnail'], projects(:one).thumbnail.url
    assert response_body['data'][1]['attributes']['createdAt'].present?
    assert response_body['data'][1]['attributes']['updatedAt'].present?
  end

  test "get all owned projects" do
    get "/api/v1/projects/my_projects",
      headers: {"Authorization" => "Bearer "+@jwt}
    assert_equal 200, status
    response_body = JSON.parse(@response.body)

    assert_equal response_body['data'][0]['type'], "project"
    assert_equal response_body['data'][0]['attributes']['title'], projects(:one).title
    assert_equal response_body['data'][0]['attributes']['description'], projects(:one).description
    assert_equal response_body['data'][0]['attributes']['type'], "in_house"
    assert_equal response_body['data'][0]['attributes']['ownerName'], @owner_name
    assert_equal response_body['data'][0]['attributes']['location'], projects(:one).location
    assert_equal response_body['data'][0]['attributes']['thumbnail'], projects(:one).thumbnail.url
    assert response_body['data'][0]['attributes']['createdAt'].present?
    assert response_body['data'][0]['attributes']['updatedAt'].present?
  end

  test "get all owned projects with no jwt" do
    get "/api/v1/projects/my_projects"
    assert_equal 401, status
  end

  test "update project" do
    put "/api/v1/projects/#{projects(:one).id}",
      params: @update_data,
      headers: {"Authorization" => "Bearer "+@jwt}
    assert_equal 201, status
    response_body = JSON.parse(@response.body)

    finded_updated_project = Project.find_by_id(projects(:one).id)

    assert_equal response_body['data']['type'], "project"
    assert_equal response_body['data']['attributes']['title'], @update_data['title']
    assert_equal response_body['data']['attributes']['description'], @update_data['description']
    assert_equal response_body['data']['attributes']['type'], "international"
    assert_equal response_body['data']['attributes']['ownerName'], @owner_name
    assert_equal response_body['data']['attributes']['location'], @update_data['location']
    assert_equal response_body['data']['attributes']['thumbnail'], finded_updated_project.thumbnail.url
    assert response_body['data']['attributes']['createdAt'].present?
    assert response_body['data']['attributes']['updatedAt'].present?
  end

  test "update project request invalid" do
    put "/api/v1/projects/#{projects(:one).id}",
      params: {:title => "test"},
      headers: {"Authorization" => "Bearer "+@jwt}
    assert_equal 400, status
  end

  test "update project with no jwt" do
    put "/api/v1/projects/#{projects(:one).id}",
      params: @update_data
    assert_equal 401, status
  end

  test "delete project" do
    delete "/api/v1/projects/#{projects(:one).id}",
      headers: {"Authorization" => "Bearer "+@jwt}
    assert_equal 200, status

    assert !Project.find_by_id(projects(:one).id).present?
  end

  test "delete project not found" do
    delete "/api/v1/projects/-1",
      headers: {"Authorization" => "Bearer "+@jwt}
    assert_equal 400, status
  end

  test "delete project with no jwt" do
    delete "/api/v1/projects/#{projects(:one).id}"
    assert_equal 401, status

    assert Project.find_by_id(projects(:one).id).present?
  end
end
