# frozen_string_literal: true

class Web::AdminController < ApplicationController
  def index
    @pagy, @bulletins = pagy Bulletin.under_moderation.order(created_at: :desc)
  end
end
