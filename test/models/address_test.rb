require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  setup do
    @address = addresses(:one)
    assert @address.valid?
  end
  test 'requires a line_1' do
    @address.line_1 = ''
    assert_not @address.valid?
  end
  test 'requires a line_2' do
    @address.line_2 = ''
    assert_not @address.valid?
  end
  test 'requires a city' do
    @address.city = ''
    assert_not @address.valid?
  end
  test 'requires a postcode' do
    @address.postcode = ''
    assert_not @address.valid?
  end
  test 'requires a country' do
    @address.country = ''
    assert_not @address.valid?
  end
  test 'requires a @addressable' do
    @address.addressable = nil
    assert_not @address.valid?
  end
end
