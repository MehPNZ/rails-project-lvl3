# frozen_string_literal: true

class Web::AuthController < ApplicationController
  def callback
    email = auth[:info][:email].downcase
    name = auth[:info][:name]
    existing_user = User.find_by(email: email)

    if existing_user
      sign_in existing_user
      redirect_to root_path, notice: t('user.welcome', user_name: name)
    else
      user = User.new(email: email, name: name)
      create_user(user)
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def create_user(user)
    if user.save
      sign_in user
      redirect_to root_path, notice: t('user.welcome', user_name: user.name)
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end
end
