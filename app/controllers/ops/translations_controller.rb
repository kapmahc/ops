require_dependency "ops/application_controller"

module Ops
  class TranslationsController < ApplicationController
    def index
      @translations = Translation.where(locale: I18n.locale).order(key: :asc)
    end

    def new
      @translation = Translation.new(locale: I18n.locale)
    end

    def create
      @translation = Translation.new translation_params
      @translation.locale = I18n.locale
      if @translation.save
        redirect_to translations_path
      else
        render 'new'
      end
    end

    def edit
      @translation = Translation.find params[:id]
    end

    def update
      @translation = Translation.find params[:id]
      if @translation.update translation_params
        redirect_to translations_path
      else
        render 'edit'
      end

    end

    def destroy
      @translation = Translation.find params[:id]
      @translation.destroy
      redirect_to translations_path
    end

    def reload
      I18n.backend.reload!
      redirect_to translations_path
    end

    private
    def translation_params
      params.require(:translation).permit(:locale, :key, :value)
    end

  end
end
