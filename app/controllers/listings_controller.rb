class ListingsController < ApplicationController
  allow_unauthenticated only: %i[show]
  before_action :load_listing, except: %i[new create index]

  def new
    @listing = Listing.new
    @listing.build_address
  end

  def create
    @listing = Listing.new(listing_params.with_defaults(creator: Current.user, organization: Current.organization))
    if @listing.save
      flash[:success] = t('.success')
      recede_or_redirect_to listings_path(@listing), status: :see_other
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
      recede_or_redirect_to listing_path(@listing), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @listing.destroy
    flash[:success] = t('.success')
    recede_or_redirect_to my_listings_path, status: :see_other
  end

  private

  def listing_params
    params
      .require(:listing)
      .permit(
        :title,
        :price,
        :condition,
        tags: [],
        address_attributes: %i[line_1 line_2 postcode city country]
      )
  end

  def load_listing
    @listing = Listing.find(params[:id])
  end
end
