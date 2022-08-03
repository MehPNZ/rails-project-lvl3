class Web::Admin::CategoriesController < ApplicationController
  after_action :verify_authorized
  before_action :set_category, only: %i[ edit update destroy ]
  before_action :authorize_user, only: %i[ edit update destroy ]

  def index
    @categories = Category.order created_at: :asc
    authorize @categories
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit
  end

  def create
    authorize Category
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @category.destroy
      redirect_to admin_categories_path, notice: "Category was successfully destroyed."
    rescue
      redirect_to admin_categories_path, notice: "Не удалось удалить категорию, так как она содержит объявления"
    end
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
