# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :country
      t.string :postcode
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
