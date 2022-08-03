# frozen_string_literal: true

require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    @user = users(:one)
    sign_in @user
    get profile_url
    assert_response :success
  end
end
