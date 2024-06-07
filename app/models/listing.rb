class Listing < ApplicationRecord
  belongs_to :organization
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  validates :title, presence: true, length: { in: 10..100 }
  validates :price, numericality: { only_integer: true }
end
