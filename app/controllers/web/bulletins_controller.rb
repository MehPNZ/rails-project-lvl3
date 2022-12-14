# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  after_action :verify_authorized, except: %i[index show to_moderate archive]
  before_action :set_bulletin, only: %i[show edit update destroy]

  def index
    @q = Bulletin.ransack(params[:q])

    @pagy, @bulletins = pagy @q.result(distinct: true).where(state: 'published').includes(:category)
  end

  def show; end

  def new
    @bulletin = Bulletin.new
    authorize @bulletin
  end

  def edit
    authorize @bulletin
  end

  def create
    authorize Bulletin
    @bulletin = current_user.bulletins.build(bulletin_params)
    if @bulletin.save
      redirect_to bulletin_url(@bulletin), notice: t('bulletin.action_create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @bulletin
    if @bulletin.update(bulletin_params)
      redirect_to bulletin_url(@bulletin), notice: t('bulletin.action_update')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @bulletin
    @bulletin.destroy
    redirect_to bulletins_url, notice: t('bulletin.action_destroy')
  end

  def to_moderate
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.archived?
      redirect_to profile_path, notice: t('bulletin.archive_ad')
    elsif @bulletin.may_to_moderate?
      @bulletin.to_moderate!
      redirect_to profile_path, notice: t('bulletin.send_moderate')
    else
      redirect_to profile_path, notice: t('bulletin.send_not_moderate')
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_to profile_path, notice: t('bulletin.archive_ad')
    else
      redirect_to profile_path, notice: t('bulletin.archive_not_ad')
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :user_id, :image)
  end
end
