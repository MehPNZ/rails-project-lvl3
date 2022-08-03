# frozen_string_literal: true

class Web::Admin::BulletinsController < ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])

    @pagy, @bulletins = pagy @q.result(distinct: true)
  end

  def publish
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.archived?
      redirect_to admin_path, notice: t('bulletin.archive_ad')
    elsif @bulletin.may_publish?
      @bulletin.publish!
      redirect_to admin_path, notice: t('bulletin.published')
    else
      redirect_to admin_path, notice: t('bulletin.published_not')
    end
  end

  def reject
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.archived?
      redirect_to admin_path, notice: t('bulletin.archive_ad')
    elsif @bulletin.may_reject?
      @bulletin.reject!
      redirect_to admin_path, notice: t('bulletin.reject')
    else
      redirect_to admin_path, notice: t('bulletin.reject_not')
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
end
