# frozen_string_literal: true

class Web::AuthController < ApplicationController
  def callback
    email = auth[:info][:email].downcase
    name = auth[:info][:name]
    existing_user = User.find_or_create_by(email: email) do |user|
      user.name = name
    end

    if existing_user
      sign_in existing_user
      redirect_to root_path, notice: t('user.welcome', user_name: name)
    else
      redirect_to root_path, notice: t('user.error_auth')
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
