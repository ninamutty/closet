class OutfitsController < ApplicationController
  before_action :find_user
  before_action :user_outfits
  before_action :all_tags
  before_action :find_outfit, only: [:show, :edit, :update, :destroy]

  def index
    @user = find_user
    @tags = params[:tags]
    if @tags != nil
      @outfits = []
      @tags.each do |tag|
        @user_outfits.each do |outfit|
          @outfits << outfit if outfit.tags.include? tag
        end
      end
      return @outfits
    else
      @outfits = @user_outfits
    end
  end


  def category
    @favorite = params[:favorite]
    @tagged_outfits = params[:tagged_outfits]
    @category = params[:category]
    @outfits = []

    if (@tagged_outfits == nil) && (@favorite == nil)
      @user_outfits.each do |outfit|
        @outfits << outfit if outfit.category == @category
      end
    elsif (@favorite == "true") && (@tagged_outfits == nil)
      @user_outfits.each do |outfit|
        @outfits << outfit if (outfit.category == @category && outfit.favorite == true)
      end
    elsif (@favorite == nil) && (@tagged_outfits != nil)
      @user_outfits.each do |outfit|
        if (outfit.category == @category) && (@tagged_outfits.include? outfit.id.to_s)
          @outfits << outfit
        end
      end
    else
      @user_outfits.each do |outfit|
        if (outfit.category == @category) && (@tagged_outfits.include? outfit.id.to_s) && (outfit.favorite == true)
          @outfits << outfit
        end
      end
    end
    return @outfits
  end

  def favorite   ###not filtering category properly
    @category = params[:category]
    @tagged_outfits = params[:tagged_outfits]
    @outfits = []

    if @category == nil && @tagged_outfits == nil
      @user_outfits.each do |outfit|
        @outfits << outfit if outfit.favorite == true
      end
    elsif @tagged_outfits != nil && @tagged_outfits.length != 0 && @category == nil
      @user_outfits.each do |outfit|
        if (outfit.favorite == true) && (@tagged_outfits.include? outfit.id.to_s)
          @outfits << outfit
        end
      end
    elsif @tagged_outfits == nil && @category != nil
      @user_outfits.each do |outfit|
        @outfits << outfit if (outfit.favorite == true && outfit.category == @category)
      end
    else
      @user_outfits.each do |outfit|
        if (outfit.category == @category) && (@tagged_outfits.include? outfit.id.to_s) && (outfit.favorite == true)
          @outfits << outfit
        end
      end
    end
    return @outfits
  end



  def tags
    @tags = params[:tags]
    if @tags == nil or @tags.length == 0
      redirect_to outfits_path
    else
      @outfits = []
      @tags.each do |tag|
        @user_outfits.each do |outfit|
          @outfits << outfit if outfit.tags.include? tag
        end
      end
    end
    return @outfits
  end



  def show
    @tags = @outfit.tags
  end

  def new
    @outfit = Outfit.new
    @post_method = :post
    @post_path = outfits_path
    @tag = Tag.order("label ASC")
  end

  def create
    @outfit = Outfit.new(outfit_params)
    @outfit.user_id = @user.id
    # @product.last
    if @outfit.save
      redirect_to outfits_path
    else
      @error = "Did not save succesfully. Please try again."
      @post_method = :post
      @post_path = outfits_path
      render :new
    end
  end

  def edit
    @post_method = :put
    @post_path = outfit_path(@outfit.id)
  end

  def update
    if @outfit.update(outfit_params)
      redirect_to outfit_path(@outfit.id)
    else
      @error = "Did not save succesfully. Please try again."
      @post_method = :put
      @post_path = outfit_path(@outfit.id)
      render :edit
    end
  end

  def destroy
    @outfit = find_outfit
    if @outfit.class == Outfit
      @outfit.destroy
      redirect_to outfits_path
    end
  end



  private

  def outfit_params
    params.require(:outfit).permit(:name, :last_worn, :category, :reworn_count, :favorite, :photo, tag_ids: [])
  end

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

  def all_tags
    return @tags = Tag.all
  end
end
