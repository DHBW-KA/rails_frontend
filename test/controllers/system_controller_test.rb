require 'test_helper'

class SystemControllerTest < ActionDispatch::IntegrationTest
  test "should get ajax" do
    get system_ajax_url
    assert_response :success
  end

  test "should get stimulus" do
    get system_stimulus_url
    assert_response :success
  end

  test "should get vue" do
    get system_vue_url
    assert_response :success
  end

  test "should get actioncable" do
    get system_actioncable_url
    assert_response :success
  end

end
