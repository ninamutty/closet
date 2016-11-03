class LandingsController < ApplicationController
  def index
    @selected = params[:selected]
    @tags = Tag.all
  end

  def add_selection(tag)
    @selected ||= []
    @selected << tag
    redirect_to landings_path(selected: @selected)
  end

  def show
  end

end
