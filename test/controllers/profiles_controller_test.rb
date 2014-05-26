require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profiles" do
    assert_difference('Profile.count') do
      post :create, profiles: { index: @profile.index }
    end

    assert_redirected_to profile_path(assigns(:profiles))
  end

  test "should show profiles" do
    get :show, id: @profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile
    assert_response :success
  end

  test "should update profiles" do
    patch :update, id: @profile, profiles: { index: @profile.index }
    assert_redirected_to profile_path(assigns(:profiles))
  end

  test "should destroy profiles" do
    assert_difference('Profile.count', -1) do
      delete :destroy, id: @profile
    end

    assert_redirected_to profiles_path
  end
end
