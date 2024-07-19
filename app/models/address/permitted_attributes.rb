# frozen_string_literal: true

class Address
  module PermittedAttributes
    extend ActiveSupport::Concern

    class_methods do
      def permitted_attributes
        %i[line_1 line_2 postcode city country]
      end
    end
  end
end
