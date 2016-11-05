class OutfitsController < ApplicationController
  before_action :find_user
  before_action :user_outfits
  before_action :find_outfit, only: [:show, :edit, :update, :destroy]

  def index
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

    # ids = params[:outfits]
    # if ids != nil
    #   outfits = []
    #   ids.each do |id|
    #     outfits << Outfit.where(user_id: @user.id).find(id.to_i)
    #   end
    #   @outfits = outfits
    # else
    #   @outfits = Outfit.where(user_id: @user.id)
    # end

    # if @outfits != nil
    #   @casual = []
    #   @business = []
    #   @night_out = []
    #   @fancy = []
    #   @outfits.each do |outfit|
    #     @casual << outfit if outfit.category == 'casual'
    #     @business << outfit if outfit.category == 'business'
    #     @night_out << outfit if outfit.category == 'night_out'
    #     @fancy << outfit if outfit.category == 'fancy'
    #   end
    #end

    # .where(category: 'casual')
    # @business = Outfit.where(user_id: @user.id).where(category: 'business')
    # @night_out = Outfit.where(user_id: @user.id).where(category: 'night_out')
    # @fancy = Outfit.where(user_id: @user.id).where(category: 'fancy')
  end

  def category
    @category = params[:category]
    @outfits = []
    @user_outfits.each do |outfit|
      @outfits << outfit if outfit.category == @category
    end
    return @outfits
  end

  def favorite
    @category = params[:category]
    @outfits = []
    if @category == nil
      @user_outfits.each do |outfit|
        @outfits << outfit if outfit.favorite == true
      end
    else
      @user_outfits.each do |outfit|
        @outfits << outfit if outfit.favorite == true && outfit.category == @category
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
end
