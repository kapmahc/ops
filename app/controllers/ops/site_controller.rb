require_dependency "ops/application_controller"

module Ops
  class SiteController < ApplicationController
    def base
    end

    def status
      @db = Rails.configuration.database_configuration[Rails.env]
    end
  end
end
