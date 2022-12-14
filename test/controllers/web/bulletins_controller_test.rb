# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @user = users(:one)
    @attrs = {
      title: Faker::Book.title,
      description: Faker::Books::Dune.quote,
      category_id: 1,
      user_id: 1,
      image: fixture_file_upload('hexlet.jpeg', 'image/jpeg')
    }
  end

  test 'should get index' do
    get bulletins_url
    assert_response :success
  end

  test 'should get new' do
    sign_in(@user)

    get new_bulletin_url
    assert_response :success
  end

  test 'should create bulletin' do
    sign_in(@user)
    post bulletins_url(locale: :en), params: { bulletin: @attrs }
    bulletin = Bulletin.find_by! title: @attrs[:title]

    assert { bulletin }
    assert_redirected_to bulletin_url(bulletin, locale: :en)
  end

  test 'should show bulletin' do
    get bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should get edit' do
    sign_in(@user)
    get edit_bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should update bulletin' do
    sign_in(@user)
    patch bulletin_url(@bulletin), params: { bulletin: @attrs }
    assert_redirected_to bulletin_url(@bulletin, locale: :ru)

    @bulletin.reload
    assert { @bulletin.title == @attrs[:title] }
  end

  test 'should destroy bulletin' do
    sign_in(@user)
    assert_difference('Bulletin.count', -1) do
      delete bulletin_url(@bulletin)
    end

    assert_redirected_to bulletins_url(locale: :ru)
  end

  test 'should to_moderate' do
    @bulletin.update(@attrs)
    patch to_moderate_bulletin_url(@bulletin)
    assert_redirected_to profile_url(locale: :ru)

    @bulletin.reload
    assert { @bulletin.state == 'under_moderation' }
  end

  test 'should to_archive' do
    @bulletin.update(@attrs)
    patch archive_bulletin_url(@bulletin)
    assert_redirected_to profile_url(locale: :ru)

    @bulletin.reload
    assert { @bulletin.state == 'archived' }
  end
end
