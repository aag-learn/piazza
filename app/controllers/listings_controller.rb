class ListingsController < ApplicationController
  allow_unauthenticated only: %i[show]
  before_action :load_listing, except: %i[new create index]
  def index
    ### TO BE DELETED!!!!! The book uses other controller to list ads
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params.with_defaults(creator: Current.user, organization: Current.organization))
    if @listing.save
      redirect_to listings_path(@listing), flash: { success: t('.success') }, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    @listing.assign_attributes listing_params
    if @listing.save
      flash[:success] = t('.success')
      redirect_to listing_path(@listing), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_path, flash: { success: t('.success') }, status: :see_other
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :price, :condition)
  end

  def load_listing
    @listing = Listing.find(params[:id])
  end
end
