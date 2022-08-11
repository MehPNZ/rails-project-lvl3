# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @attrs_admin = {
      image: fixture_file_upload('hexlet.jpeg', 'image/jpeg'),
      state: 'under_moderation'
    }
  end

  test 'should get admin_index' do
    get admin_bulletins_url
    assert_response :success
  end

  test 'admin_archive' do
    @bulletin.update(@attrs_admin)
    patch archive_admin_bulletin_url(@bulletin)
    assert_redirected_to profile_url(locale: :ru)

    @bulletin.reload
    assert { @bulletin.state == 'archived' }
  end

  test 'admin_publish' do
    @bulletin.update(@attrs_admin)
    patch publish_admin_bulletin_url(@bulletin)
    assert_redirected_to admin_url(locale: :ru)

    @bulletin.reload
    assert { @bulletin.state == 'published' }
  end

  test 'admin_reject' do
    @bulletin.update(@attrs_admin)
    patch reject_admin_bulletin_url(@bulletin)
    assert_redirected_to admin_url(locale: :ru)

    @bulletin.reload
    assert { @bulletin.state == 'rejected' }
  end
end
