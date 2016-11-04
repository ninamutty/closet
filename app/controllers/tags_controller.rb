class TagsController < ApplicationController
  def index
    @tags = Tags.all
  end

  # def find_tag_outfits
  #   @params_tags = params["search_tags"]
  #   @tags = []
  #   @params_tags.each do |label|
  #     @tags << Tag.where(label: label)
  #   end
  #
  #   outfits = []
  #   @tags.each do |tag|
  #     outfits << tag[:tag].outfits
  #   end
  #   redirect_to outfits_path(outfits)
  #end

  def show
    @params_tags = params["search_tags"]
    @tags = []
    @params_tags.each do |label|
      tag = Tag.where(label: label)
      @tags << tag.first
    end

    outfits = []
    @tags.each do |tag|
      tag.outfits.each do |outfit|
        outfits << outfit
      end
    end
    redirect_to outfits_path(outfits: outfits)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
