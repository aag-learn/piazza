# fronzen_string_literal: true

class AddTagsArrayToListings < ActiveRecord::Migration[7.1]
  def change
    add_column :listings, :tags, :string, array: true, default: []
  end
end
