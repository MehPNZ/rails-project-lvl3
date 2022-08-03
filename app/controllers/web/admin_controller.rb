class Web::AdminController < ApplicationController
  before_action :set_bulletin, only: %i[ show edit update destroy ]

  def index
    @pagy, @bulletins = pagy Bulletin.where(aasm_state: 'under_moderation').order(created_at: :desc)
  end
end