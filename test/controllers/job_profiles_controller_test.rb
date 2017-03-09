require 'test_helper'

class JobProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_profile = job_profiles(:one)
  end

  test "should get index" do
    get job_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_job_profile_url
    assert_response :success
  end

  test "should create job_profile" do
    assert_difference('JobProfile.count') do
      post job_profiles_url, params: { job_profile: { alternativeernative: @job_profile.alternativeernative, career_path: @job_profile.career_path, description: @job_profile.description, duties: @job_profile.duties, entry: @job_profile.entry, hours: @job_profile.hours, pay: @job_profile.pay, related: @job_profile.related, salary: @job_profile.salary, skills: @job_profile.skills, title: @job_profile.title, working_hours: @job_profile.working_hours } }
    end

    assert_redirected_to job_profile_url(JobProfile.last)
  end

  test "should show job_profile" do
    get job_profile_url(@job_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_profile_url(@job_profile)
    assert_response :success
  end

  test "should update job_profile" do
    patch job_profile_url(@job_profile), params: { job_profile: { alternativeernative: @job_profile.alternativeernative, career_path: @job_profile.career_path, description: @job_profile.description, duties: @job_profile.duties, entry: @job_profile.entry, hours: @job_profile.hours, pay: @job_profile.pay, related: @job_profile.related, salary: @job_profile.salary, skills: @job_profile.skills, title: @job_profile.title, working_hours: @job_profile.working_hours } }
    assert_redirected_to job_profile_url(@job_profile)
  end

  test "should destroy job_profile" do
    assert_difference('JobProfile.count', -1) do
      delete job_profile_url(@job_profile)
    end

    assert_redirected_to job_profiles_url
  end
end
