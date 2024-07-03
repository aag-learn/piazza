# frozen_string_literal: true

class Listing < ApplicationRecord
  include HumanEnum

  belongs_to :organization
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  before_save :downcase_tags

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

  private

  def downcase_tags
    tags.map!(&:downcase)
  end
end
