require 'test_helper'

class AccreditationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @accreditation = accreditations(:one)
  end

  test "should get index" do
    get accreditations_url
    assert_response :success
  end

  test "should get new" do
    get new_accreditation_url
    assert_response :success
  end

  test "should create accreditation" do
    assert_difference('Accreditation.count') do
      post accreditations_url, params: { accreditation: { accdepend: @accreditation.accdepend, accdependurl: @accreditation.accdependurl, acctext: @accreditation.acctext, acctype: @accreditation.acctype, accurl: @accreditation.accurl, kiscourse: @accreditation.kiscourse, kismode: @accreditation.kismode, pubukprn: @accreditation.pubukprn, ukprn: @accreditation.ukprn } }
    end

    assert_redirected_to accreditation_url(Accreditation.last)
  end

  test "should show accreditation" do
    get accreditation_url(@accreditation)
    assert_response :success
  end

  test "should get edit" do
    get edit_accreditation_url(@accreditation)
    assert_response :success
  end

  test "should update accreditation" do
    patch accreditation_url(@accreditation), params: { accreditation: { accdepend: @accreditation.accdepend, accdependurl: @accreditation.accdependurl, acctext: @accreditation.acctext, acctype: @accreditation.acctype, accurl: @accreditation.accurl, kiscourse: @accreditation.kiscourse, kismode: @accreditation.kismode, pubukprn: @accreditation.pubukprn, ukprn: @accreditation.ukprn } }
    assert_redirected_to accreditation_url(@accreditation)
  end

  test "should destroy accreditation" do
    assert_difference('Accreditation.count', -1) do
      delete accreditation_url(@accreditation)
    end

    assert_redirected_to accreditations_url
  end
end
