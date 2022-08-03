class Web::Admin::BulletinsController < ApplicationController

  def index
    @q = Bulletin.ransack(params[:q])
    
    @pagy, @bulletins = pagy @q.result(distinct: true)
  end

  def publish
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.archived?
      redirect_to admin_path, notice: "Archive bulletin"
    elsif @bulletin.may_publish?
      @bulletin.publish!
      redirect_to admin_path, notice: "Bulletin published"
    else
      redirect_to admin_path, notice: "Bulletin not published"
    end
  end

  def reject
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.archived?
      redirect_to admin_path, notice: "Archive bulletin"
    elsif @bulletin.may_reject?
      @bulletin.reject!
      redirect_to admin_path, notice: "Bulletin rejected"
    else
      redirect_to admin_path, notice: "Bulletin not rejected"
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_to profile_path, notice: "The bulletin has been archived"
    else
      redirect_to profile_path, notice: "The bulletin has not been archived"
    end
  end
end
