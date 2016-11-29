module Spree
  module Admin
    class <%= class_name.pluralize %>Controller < ResourceController
      def index
        @<%= plural_name %> = Spree::<%= class_name %>.page(params[:page] || 1).per(50)
      end
    end
  end
end