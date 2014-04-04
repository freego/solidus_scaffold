module Spree
  module Admin
    class <%= class_name.pluralize %>Controller < ResourceController

      def index
        @<%= model_name.pluralize %> = <%= class_path %>.page(params[:page] || 1).per(50)
      end

      def new
        @<%= model_name %> = <%= class_path %>.new
      end

      def create
        @<%= model_name %> = <%= class_path %>.new(<%= model_name %>_params)
        if @<%= model_name %>.save
          flash[:notice] = "Successfully created <%= display_name %>."
          redirect_to admin_<%= model_name.pluralize %>_url
        else
          render :action => 'new'
        end
      end

      def edit
        @<%= model_name %> = <%= class_path %>.find(params[:id])
      end

      def update
        @page = <%= class_path %>.find(params[:id])
        if @<%= model_name %>.update_attributes(<%= model_name %>_params)
          flash[:notice] = "Successfully updated <%= display_name %>."
          redirect_to admin_<%= model_name.pluralize %>_url
        else
          render :action => 'edit'
        end
      end

      def destroy
        @<%= model_name %> = <%= class_path %>.find(params[:id])
        @<%= model_name %>.destroy
        flash[:notice] = "Successfully destroyed <%= display_name %>."
        redirect_to admin_<%= model_name.pluralize %>_url
      end

      private
      def <%= model_name %>_params
        params.require(:<%= model_name %>).permit([<%= model_attributes.map { |attribute| ":#{attribute.name}" }.join(',') %>])
      end
    end
  end
end