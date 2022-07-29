class Web::AuthController < ApplicationController
  def callback
    user_email = auth[:info][:email].downcase
    user_name = auth[:info][:name]
    existing_user = User.find_by(email: user_email)

    if existing_user
       sign_in existing_user
       redirect_to root_path, notice: "Welcome, #{user_name}!"
    else
      @user = User.new(email: user_email, name: user_name)
      if @user.save
        sign_in @user
        redirect_to root_path, notice:  "Welcome, #{user_name}!"
      else
        redirect_to root_path, status: :unprocessable_entity
      end
    end

  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
