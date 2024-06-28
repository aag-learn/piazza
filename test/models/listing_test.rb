require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  setup do
    @creator = users(:jerry)
    @organization = organizations(:one)
  end

  test 'Requires a title' do
    listing = Listing.new(title: '', price: 1000, creator: @creator, organization: @organization)
    assert_not listing.valid?

    listing.title = 'A valid title'
    assert listing.valid?
  end

  test 'Title should be between 10 and 100 characters' do
    listing = Listing.new(title: 'A valid title', price: 1000, creator: @creator, organization: @organization)
    assert listing.valid?

    listing.title = 'The'
    assert_not listing.valid?

    listing.title = 'x' * 101
    assert_not listing.valid?
  end

  test 'Price should be an integer' do
    listing = Listing.new(title: 'A valid title', price: 1000, creator: @creator, organization: @organization)
    assert listing.valid?

    listing.price = 1000.5
    assert_not listing.valid?
  end
end
