# frozen_string_literal: true

class Address < ApplicationRecord
  include Address::PermittedAttributes

  attribute :country, :string, default: 'ES'

  belongs_to :addressable, polymorphic: true

  validates :line_1, presence: true
  validates :line_2, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :postcode, presence: true

  def redacted
    "#{postcode}, #{city}, #{ISO3166::Country.new(country).common_name}"
  end
end
