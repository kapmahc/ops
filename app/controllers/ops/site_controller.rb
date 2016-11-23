require_dependency "ops/application_controller"

module Ops
  class SiteController < ApplicationController
    def info
      case request.method
        when 'POST'
          params.require(:info).permit(:title, :sub_title, :author, :keywords, :description, :copyright).each{|k, v| Setting["#{I18n.locale}://site/#{k}"] = v}
          flash[:notice] = ''
        else
      end
    end

    def seo
      case request.method
        when 'POST'
          params.require(:seo).permit(:google_verify_code, :baidu_verify_code).each{|k, v| Setting[k] = v}
          flash[:notice] = ''
        else
      end
    end

    def status
      @db = Rails.configuration.database_configuration[Rails.env]
    end
  end
end
