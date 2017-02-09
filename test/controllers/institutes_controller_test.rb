require 'test_helper'

class InstitutesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @institute = institutes(:one)
  end

  test "should get index" do
    get institutes_url
    assert_response :success
  end

  test "should get new" do
    get new_institute_url
    assert_response :success
  end

  test "should create institute" do
    assert_difference('Institute.count') do
      post institutes_url, params: { institute: { description: @institute.description, name: @institute.name, picture: @institute.picture, url: @institute.url } }
    end

    assert_redirected_to institute_url(Institute.last)
  end

  test "should show institute" do
    get institute_url(@institute)
    assert_response :success
  end

  test "should get edit" do
    get edit_institute_url(@institute)
    assert_response :success
  end

  test "should update institute" do
    patch institute_url(@institute), params: { institute: { description: @institute.description, name: @institute.name, picture: @institute.picture, url: @institute.url } }
    assert_redirected_to institute_url(@institute)
  end

  test "should destroy institute" do
    assert_difference('Institute.count', -1) do
      delete institute_url(@institute)
    end

    assert_redirected_to institutes_url
  end
end
