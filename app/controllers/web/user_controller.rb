# frozen_string_literal: true

class Web::UserController < ApplicationController
  def show
    @q = Bulletin.ransack(params[:q])

    @pagy, @bulletins = pagy @q.result.where(user_id: current_user.id).order(created_at: :desc)
  end
end
