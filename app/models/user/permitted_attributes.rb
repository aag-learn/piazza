class User
  module PermittedAttributes
    extend ActiveSupport::Concern
    class_methods do
      def permitted_attributes
        %i[name email password password_confirmation]
      end
    end
  end
end
