# frozen_string_literal: true

class Listing < ApplicationRecord
  include HumanEnum
  include HasAddress
  include Listing::PermittedAttributes

  belongs_to :organization
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  before_save :downcase_tags, :remove_empty_tags
  before_validation :remove_empty_tags

  enum condition: {
    mint: 'mint',
    near_mint: 'near_mint',
    used: 'used',
    defective: 'defective'
  }
  validates :title, presence: true, length: { in: 10..100 }
  validates :price, numericality: { only_integer: true }
  validates :condition, presence: true
  validates :tags, length: { in: 1..5 }

  scope :feed, -> { order(created_at: :desc).includes(:address) }

  private

  def downcase_tags
    tags.map!(&:downcase)
  end

  def remove_empty_tags
    self.tags = tags.reject(&:empty?)
  end
end
