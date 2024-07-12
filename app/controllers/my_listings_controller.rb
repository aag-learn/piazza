class MyListingsController < ApplicationController
  def show # GET /my_listings
    @pagy, @listings = pagy(Current.organization.listings)
  end
end
