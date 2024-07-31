require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  setup do
    @creator = users(:jerry)
    @organization = organizations(:one)
    address_attributes = {
      line_1: Faker::Address.street_address,
      line_2: Faker::Address.secondary_address,
      postcode: Faker::Address.zip,
      city: Faker::Address.city,
      country: Faker::Address.country_code
    }
    @listing = Listing.new(title: 'A valid title', condition: :mint, price: 1000, creator: @creator, tags: ['oneTag'],
                           cover_photo: active_storage_blobs(:blob_1),
                           organization: @organization, address_attributes:)
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

  test 'Empty string tags are ignored' do
    @listing.tags = ['Ruby', 'Rails', 'PostgreSQL', '']
    assert @listing.save
    assert_equal %w[ruby rails postgresql], @listing.tags
  end

  test 'A tag with an empty string is not valid' do
    @listing.tags = ['']
    assert @listing.invalid?
    assert_equal ['You need to specify at least one tag'], @listing.errors[:tags]
  end
end
