require "test_helper"

class ProjectTest < ActiveSupport::TestCase

  test "project save" do
    project = Project.new({
      "user_id": users(:one).id,
      "title": "project title",
      "description": "test project",
      "projectType": 0,
      "location": "seoul",
      "thumbnail": File.new(Rails.root.join("test/fixtures/files/test_image.png"))
    })
    assert project.save, "Failed to save"
  end

  test "project validate" do
    project = Project.new({
      "user_id": users(:one).id,
      "title": "",
      "description": "",
      "projectType": 0,
      "location": "",
      "thumbnail": ""
    })
    assert !project.save, "Failed to validate"
    assert_equal project.errors.size, 3, "Failed to validate count"
  end

  test "project foreign key user" do
    project = Project.new({
      "user_id": -1,
      "title": "project title",
      "description": "test project",
      "projectType": 0,
      "location": "seoul",
      "thumbnail": File.new(Rails.root.join("test/fixtures/files/test_image.png"))
    })
    assert !project.save, "Failed to validate"
  end

  test "project thumbnail not file" do
    project = Project.new({
      "user_id": users(:one).id,
      "title": "project title",
      "description": "test project",
      "projectType": 0,
      "location": "seoul",
      "thumbnail": "test"
    })
    assert !project.save, "Failed to validate"
    assert project.errors[:thumbnail].any?, "Failed to thumbnail validate"
  end
end
