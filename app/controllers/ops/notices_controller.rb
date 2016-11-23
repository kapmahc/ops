require_dependency "ops/application_controller"

module Ops
  class NoticesController < ApplicationController
    def new
      @notice = Notice.new
    end

    def create
      @notice = Notice.new(notice_params)
      @notice.lang = I18n.locale

      if @notice.save
        redirect_to notices_path
      else
        render 'new'
      end
    end

    def edit
      @notice = Notice.find(params[:id])
    end

    def update
      @notice = Notice.find(params[:id])
      if @notice.update(notice_params)
        redirect_to notices_path
      else
        render 'edit'
      end

    end

    def destroy
      n = Notice.find(params[:id])
      n.destroy

      redirect_to notices_path
    end

    private
    def notice_params
      params.require(:notice).permit(:body)
    end
  end
end
