require_dependency 'ops/application_controller'

require 'forum/version'
require 'ops/version'
require 'shop/version'
require 'reading/version'

module Ops
  class SiteController < ApplicationController
    def info
      case request.method
        when 'POST'
          params.require(:info).permit(:title, :sub_title, :author, :keywords, :description, :copyright).each { |k, v| Setting["#{I18n.locale}://site/#{k}"] = v }
          flash[:notice] = ''
        else
      end
    end

    def seo
      case request.method
        when 'POST'
          params.require(:seo).permit(:google_verify_code, :baidu_verify_code).each { |k, v| Setting[k] = v }
          flash[:notice] = ''
        else
      end
    end

    def nav
      @locs = [:top, :bottom]
      case request.request_method
        when 'POST'
          begin
            link = params.require(:nav).permit(:engine, :loc, :path, :label, :order)
            key = "nav://#{link.fetch :loc}"

            en = link.fetch(:engine)
            if en == ''
              en = 'main_app'
            else
              en = en.downcase
            end

            send(en).send(link.fetch(:path))

            links = Setting[key]
            if links.nil?
              links = []
            end
            links << link.permit(:path, :label, :order).merge(engine: en)
            Setting[key] = links.sort_by {|i| i.fetch(:order)}
          rescue => e
            flash[:alert] = e.inspect
          end
        when 'PUT'
          link = params.permit(:engine, :loc, :path, :order, :label)
          key = "nav://#{link.fetch :loc}"
          links = Setting[key]
          if links.nil?
            links = []
          end

          Setting[key] = links.delete_if {|i| i == link.permit(:engine, :path, :order, :label)}
        else
      end
    end

    def engines
      case request.method
        when 'POST'
          name = params.fetch(:name)
          if Rails.application.config.magnolia['engines'].include? name
            Setting['home'] = name.downcase
          else
            flash[:alert] = t('.not_exist', name: name)
          end
        else
      end
    end

    def status
      @db = Rails.configuration.database_configuration[Rails.env]
    end

    def ping
      SitemapGenerator::Sitemap.default_host = "https://#{ENV['HOST']}"
      SitemapGenerator::Sitemap.ping_search_engines
      
      redirect_to :back
    end
  end
end
