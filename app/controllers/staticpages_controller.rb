class StaticpagesController < ApplicationController
  def help
    respond_to do |format|
      format.html {render :help}
    end

  end
end
