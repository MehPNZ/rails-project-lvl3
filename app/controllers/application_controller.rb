# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthConcern
  include Pundit::Authorization
  include Pagy::Backend

  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale

    if I18n.available_locales.index(locale.to_sym)
      I18n.with_locale(locale, &action)
    else
      flash[:notice] = t('language_error')
      I18n.with_locale(I18n.default_locale, &action)
      flash.clear
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
