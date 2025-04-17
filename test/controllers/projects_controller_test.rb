require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get projects_index_url
    assert_response :success
  end

  test "should get show" do
    get projects_show_url
    assert_response :success
  end

  test "should get new" do
    get projects_new_url
    assert_response :success
  end

  test "should get create" do
    get projects_create_url
    assert_response :success
  end

  test "should get edit" do
    get projects_edit_url
    assert_response :success
  end

  test "should get update" do
    get projects_update_url
    assert_response :success
  end

  test "should get destroy" do
    get projects_destroy_url
    assert_response :success
  end

  test "should get change_status" do
    get projects_change_status_url
    assert_response :success
  end

  test "should get public_show" do
    get projects_public_show_url
    assert_response :success
  end

  test "should get public_update" do
    get projects_public_update_url
    assert_response :success
  end
end
