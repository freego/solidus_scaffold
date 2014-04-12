module Spree
  module Admin
    class <%= class_name.pluralize %>Controller < ResourceController

      def index
        @<%= plural_name %> = Spree::<%= class_name %>.page(params[:page] || 1).per(50)
      end

      def new
        @<%= singular_name %> = Spree::<%= class_name %>.new
      end

      def create
        @<%= singular_name %> = Spree::<%= class_name %>.new(<%= plural_name %>_params)
        if @<%= singular_name %>.save
          flash[:success] = "Successfully created <%= singular_name %>."
          redirect_to admin_<%= plural_name %>_url
        else
          render :action => 'new'
        end
      end

      def edit
        @<%= singular_name %> = Spree::<%= class_name %>.find(params[:id])
      end

      def update
        @page = Spree::<%= class_name %>.find(params[:id])
        if @<%= singular_name %>.update_attributes(<%= plural_name %>_params)
          flash[:success] = "Successfully updated <%= singular_name %>."
          redirect_to admin_<%= plural_name %>_url
        else
          render :action => 'edit'
        end
      end

      def destroy
        @<%= singular_name %> = Spree::<%= class_name %>.find(params[:id])
        @<%= singular_name %>.destroy
        flash[:success] = "Successfully destroyed <%= singular_name %>."
        redirect_to admin_<%= plural_name %>_url
      end

      private
      def <%= plural_name %>_params
        params.require(:<%= singular_name %>).permit([<%= attributes.map { |attribute| ":#{attribute.name}" }.join(',') %>])
      end
    end
  end
end