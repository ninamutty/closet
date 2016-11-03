class OutfitsController < ApplicationController
  before_action :find_outfit, only: [:show, :edit, :update, :destroy]

  def index
    @outfits = Outfit.all
    @casual = Outfit.where(category: 'casual')
    @business = Outfit.where(category: 'business')
    @night_out = Outfit.where(category: 'night_out')
    @fancy = Outfit.where(category: 'fancy')
  end

  def category
    @outfits = Outfit.where(category: params[:category])
  end

  def favorite
    @outfits = Outfit.where(favorite: true)
  end

  def show
  end

  def new
    @outfit = Outfit.new
    @post_method = :post
    @post_path = outfits_path
  end

  def create
    @outfit = Outfit.new(outfit_params)
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
    params.require(:outfit).permit(:name, :last_worn, :category, :reworn_count, :favorite, :photo)
  end

  def find_outfit
    @outfit = Outfit.find(params[:id].to_i)
  end
end