require 'test_helper'

class DockerControllerTest < ActionController::TestCase
  test "should get hosts" do
    get :hosts
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get containers" do
    get :containers
    assert_response :success
  end

end
