require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  setup do
    @creator = users(:jerry)
    @organization = organizations(:one)
    @listing = Listing.new(title: 'A valid title', condition: :mint, price: 1000, creator: @creator,
                           organization: @organization)
    assert @listing.valid?
  end

  test 'Requires a title' do
    @listing.title = ''
    assert_not @listing.valid?
  end

  test 'Title should be between 10 and 100 characters' do
    @listing.title = 'The'
    assert_not @listing.valid?

    @listing.title = 'x' * 101
    assert_not @listing.valid?
  end

  test 'Price should be an integer' do
    @listing.price = 1000.5
    assert_not @listing.valid?
  end

  test 'Requires a condition' do
    @listing.condition = nil
    assert_not @listing.valid?
  end

  test 'downcase tags before saving' do
    @listing.tags = %w[Ruby Rails PostgreSQL]
    @listing.save
    assert_equal %w[ruby rails postgresql], @listing.tags
  end
end
