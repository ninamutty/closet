class TagsController < ApplicationController
  before_action :find_user
  before_action :user_outfits

  def index
    @tags = params[:tags]
    if params["outfits"] == nil || params["outfits"].length == 0
      flash[:notice] = "Could not find any outfits matching those specifications"
      redirect_to outfits_path
    else
      outfit_numbers = params["outfits"]
      @outfits = []

      freq_hash = outfit_numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
      frequency = freq_hash.values.max
      unique_outfit_numbers =  outfit_numbers.select{|element| outfit_numbers.count(element) >= frequency }.uniq

      unique_outfit_numbers.each do |number|
        unless @outfits.include? Outfit.find(number.to_i) && Outfit.find(number.to_i).user_id == @user.id
          @outfits << Outfit.find(number.to_i)
        end
      end
    end
    return @outfits
  end

  def find_tag_outfits
    params_tags = params["search_tags"]
    @tags = []
    params_tags.each do |label|
      @tags << Tag.where(label: label)
    end
    redirect_to tags_path(@tags)
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
