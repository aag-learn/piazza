class FeedController < ApplicationController
  allow_unauthenticated

  def show
    @pagy, @listings = pagy(Listing.feed.limit(24))
  end
end
