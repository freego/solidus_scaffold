require 'rails/generators'
require 'rails/generators/generated_attribute'

module SpreeScaffold
  module Generators
    class ScaffoldGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      attr_accessor :scaffold_name, :model_attributes, :controller_actions

      argument :scaffold_base_name, :type => :string, :required => true, :banner => 'ModelName'
      argument :model_attribute_args, :type => :array, :default => [], :banner => 'model:attributes'

      def initialize(*args, &block)
        super
        print_usage unless scaffold_base_name.underscore =~ /^[a-z][a-z0-9_\/]+$/

        @model_attributes = []
        model_attribute_args.each do |arg|
          if arg.include?(':')
            @model_attributes << Rails::Generators::GeneratedAttribute.new(*arg.split(':'))
          end
        end

        @scaffold_name = "Spree::#{scaffold_base_name}"
      end

      def create_model
        template 'model.rb', "app/models/spree/#{model_name}.rb"
      end

      def create_controller
        template 'controller.rb', "app/controllers/spree/admin/#{model_name.pluralize}_controller.rb"
      end

      def create_views
        ['index','new','edit','_form'].each do |view|
          template "views/#{view}.html.erb", "app/views/spree/admin/#{model_name.pluralize}/#{view}.html.erb"
        end
      end

      def create_migration
        stamp =  Time.now.utc.strftime("%Y%m%d%H%M%S")
        template 'migration.rb', "db/migrate/#{stamp}_create_spree_#{model_name.pluralize}.rb"
      end

      def create_locale
        template 'en.yml', "config/locales/en_spree_#{model_name.pluralize}.yml"
      end

      def create_deface_override
        template 'overrides/add_to_admin_menu.rb', "app/overrides/spree/admin/add_spree_#{model_name.pluralize}_to_admin_menu.rb"
      end

      def create_routes
        append_file 'config/routes.rb',
<<-eos
Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :#{model_name.pluralize}
  end
end
eos
      end

      private
      def model_path
        scaffold_name.tableize.tr('/', '_')
      end

      def model_name
        scaffold_name.demodulize.underscore.downcase
      end

      def class_path
        scaffold_name.camelize
      end

      def class_name
        scaffold_name.demodulize.camelize
      end

      def table_name
        scaffold_name.downcase.underscore.pluralize
      end

      def display_name
        scaffold_name.underscore.titleize
      end

      def display_name_plural
        scaffold_name.underscore.titleize.pluralize
      end

    end
  end
end