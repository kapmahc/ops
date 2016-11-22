module Ops
  class ApplicationController < ActionController::Base
    include Pundit
    protect_from_forgery with: :exception

    before_action :set_locale
    layout 'dashboard'


    def default_url_options
      { locale: I18n.locale }
    end

    protected
    def set_locale
      I18n.locale = params[:locale] || browser.accept_language.first.full
    end
  end
end
