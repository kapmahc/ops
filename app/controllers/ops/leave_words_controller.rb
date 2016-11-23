require_dependency 'ops/application_controller'

module Ops
  class LeaveWordsController < ApplicationController

    def destroy
      lw = LeaveWord.find(params[:id])
      lw.destroy

      redirect_to leave_words_path
    end
  end
end
