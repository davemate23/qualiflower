require 'test_helper'

class JobCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_category = job_categories(:one)
  end

  test "should get index" do
    get job_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_job_category_url
    assert_response :success
  end

  test "should create job_category" do
    assert_difference('JobCategory.count') do
      post job_categories_url, params: { job_category: { ancestry: @job_category.ancestry, description: @job_category.description, entry: @job_category.entry, name: @job_category.name, related: @job_category.related, tasks: @job_category.tasks } }
    end

    assert_redirected_to job_category_url(JobCategory.last)
  end

  test "should show job_category" do
    get job_category_url(@job_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_category_url(@job_category)
    assert_response :success
  end

  test "should update job_category" do
    patch job_category_url(@job_category), params: { job_category: { ancestry: @job_category.ancestry, description: @job_category.description, entry: @job_category.entry, name: @job_category.name, related: @job_category.related, tasks: @job_category.tasks } }
    assert_redirected_to job_category_url(@job_category)
  end

  test "should destroy job_category" do
    assert_difference('JobCategory.count', -1) do
      delete job_category_url(@job_category)
    end

    assert_redirected_to job_categories_url
  end
end
