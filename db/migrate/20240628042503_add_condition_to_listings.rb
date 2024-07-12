# frozen_string_literal: true

class AddConditionToListings < ActiveRecord::Migration[7.1]
  def up
    create_enum :listing_condition, %w[mint near_mint used defective]
    add_column :listings, :condition, :enum, enum_type: :listing_condition
  end

  def down
    remove_column :listings, :condition
    drop_enum :listing_condition
  end
end
