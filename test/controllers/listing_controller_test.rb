require 'test_helper'

class ListingControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
    log_in @user
  end

  test 'can create a listing' do
    assert_difference 'Listing.count', 1 do
      address_attributes = {
        line_1: Faker::Address.street_address,
        line_2: Faker::Address.secondary_address,
        postcode: Faker::Address.zip,
        city: Faker::Address.city,
        country: Faker::Address.country_code
      }
      post listings_path,
           params: { listing: { title: 'The listing title', price: 1, condition: :near_mint, tags: %w[tagOne tagTwo],
                                address_attributes: } }
    end
  end

  test 'error when creating an invalid listing' do
    assert_difference 'Listing.count', 0 do
      post listings_path, params: { listing: { title: 'short', price: 1 } }
      assert_response :unprocessable_entity
      assert_select '.is-danger', text: /is too short/
    end
  end

  test 'can update a listing' do
    new_title = Faker::Commerce.product_name
    new_price = Faker::Commerce.price.floor
    address_attributes = {
      line_1: Faker::Address.street_address,
      line_2: Faker::Address.secondary_address,
      postcode: Faker::Address.zip,
      city: Faker::Address.city,
      country: Faker::Address.country_code
    }
    params = { listing: { title: new_title, price: new_price, address_attributes: } }
    listing = listings(:auto_listing_1_jerry)

    patch(listing_path(listing), params:)
    assert_redirected_to listing_path(listing)
    listing.reload
    assert_equal new_title, listing.title
    assert_equal new_price, listing.price
    assert_equal address_attributes[:line_1], listing.address.line_1
    assert_equal address_attributes[:line_2], listing.address.line_2
    assert_equal address_attributes[:postcode], listing.address.postcode
    assert_equal address_attributes[:city], listing.address.city
    assert_equal address_attributes[:country], listing.address.country
  end

  test 'error when updating an invalid listing with invalid parameters' do
    new_title = ''
    new_price = 0.5
    new_tags = []
    params = { listing: { title: new_title, price: new_price, tags: new_tags } }
    listing = listings(:auto_listing_1_jerry)
    old_title = listing.title
    old_price = listing.price
    old_tags = listing.tags

    patch(listing_path(listing), params:)
    assert_response :unprocessable_entity
    assert_select '.is-danger', text: /is too short/
    assert_select '.is-danger', text: /integer/
    assert_select '.is-danger', text: /You need to specify at least one tag/
    listing.reload
    assert_equal old_title, listing.title
    assert_equal old_price, listing.price
    assert_equal old_tags, listing.tags
  end

  test 'can delete a listing' do
    listing = listings(:auto_listing_1_jerry)
    assert_difference 'Listing.count', -1 do
      delete listing_path(listing)
    end
    assert_redirected_to listings_path
    follow_redirect!
    assert_select '.notification', text: /#{I18n.t('listings.destroy.success')}/
  end
end
