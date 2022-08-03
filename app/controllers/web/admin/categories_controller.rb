# frozen_string_literal: true

class Web::Admin::CategoriesController < ApplicationController
  after_action :verify_authorized
  before_action :set_category, only: %i[edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def index
    @categories = Category.order created_at: :asc
    authorize @categories
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit; end

  def create
    authorize Category
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: t('category.action_create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('category.action_update')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: t('category.action_update')
  rescue StandardError
    redirect_to admin_categories_path, notice: t('category.destroy_warning')
  end

  private

  def authorize_user
    authorize @category
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
