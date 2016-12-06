require_dependency "ops/application_controller"

module Ops
  class UsersController < ApplicationController
    def index
      @users = User.select(:id, :last_sign_in_at, :name, :email).order(last_sign_in_at: :desc).page params[:page]
    end
  end
end
