class TagsController < ApplicationController
  before_action :find_user
  before_action :user_outfits

  def index
    @category = params["category"]
    @tags = params["search_tags"]
    @favorite = params["favorite"]

    if @tags == nil
      flash[:notice] = "Please select a filter to search outfits"
      redirect_to landings_path
    else
      filtered_outfits = []
      @user_outfits.each do |outfit|
        if @category != nil
          if outfit.category != @category then
            next
          end
        end

################ THIS NEEDS REWORKING TO ACCOUNT FOR FAVORITES ##########

        labels = []
        tags = outfit.tags
        tags.each do |tag|
          labels << tag.label
        end
        if (@tags-labels).empty? == true
          filtered_outfits << outfit
        end
      end

      @outfits = filtered_outfits
    end
    return @outfits
  end




  def find_tag_outfits
    category = params[:category]
    params_tags = params["search_tags"]
    @tags = []
    params_tags.each do |label|
      @tags << Tag.where(label: label)
    end
    redirect_to tags_path(@tags, category: category)
  end

  def show
    @params_tags = params["search_tags"]
    unless @params_tags == nil || @params_tags.length == 0
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
    end
    redirect_to tags_path(outfits: outfits)
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

  private
  def find_outfit
    if Outfit.exists?(params[:id].to_i) == true && Outfit.find(params[:id].to_i).user == @user
      return @outfit = Outfit.find(params[:id].to_i)
    else
      render :status => 404
    end
  end

  def find_user  ##This may need to change - look at betsy
    if User.exists?(session[:user_id].to_i) == true
      return @user = User.find(session[:user_id].to_i)
    else
      render :status => 404
    end
  end

  def user_outfits
    return @user_outfits = Outfit.where(user_id: @user.id)
  end
end
