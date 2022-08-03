# frozen_string_literal: true

class Web::AdminController < ApplicationController
  def index
    @pagy, @bulletins = pagy Bulletin.where(aasm_state: 'under_moderation').order(created_at: :desc)
  end
end
