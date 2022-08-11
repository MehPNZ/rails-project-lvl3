# frozen_string_literal: true

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    @user = users(:one)
  end

  test 'should get new' do
    sign_in @user
    get new_admin_category_url
    assert_response :success
  end

  test 'should create category' do
    sign_in @user
    post admin_categories_url, params: { category: { name: 'Food' } }
    category = Category.find_by! name: 'Food'

    assert { category }
    assert_redirected_to admin_categories_url(locale: :ru)
  end

  test 'should get edit' do
    sign_in @user
    get edit_admin_category_url(@category)
    assert_response :success
  end

  test 'should update category' do
    sign_in @user
    patch admin_category_url(@category), params: { category: { name: @category.name } }
    assert_redirected_to admin_categories_url(locale: :ru)
  end

  test 'should destroy category' do
    category = categories(:two)
    sign_in(@user)
    assert_difference('Category.count', -1) do
      delete admin_category_url(category)
    end

    assert_redirected_to admin_categories_url(locale: :ru)
  end
end
