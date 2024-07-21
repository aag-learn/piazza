class MyListingsController < ApplicationController
  def show # GET /my_listings
    @pagy, @listings = pagy(Current.organization.listings, limit: 24)
  end
end
