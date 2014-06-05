require 'rails/generators/named_base'

module SpreeScaffold
  module Generators
    class ScaffoldGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../../templates', __FILE__)

      argument :attributes, type: :array, default: [], banner: 'field:type field:type'

      def create_model
        template 'model.rb', "app/models/spree/#{singular_name}.rb"
      end

      def create_controller
        template 'controller.rb', "app/controllers/spree/admin/#{plural_name}_controller.rb"
      end

      def create_views
        ['index','new','edit','_form'].each do |view|
          template "views/#{view}.html.erb", "app/views/spree/admin/#{plural_name}/#{view}.html.erb"
        end
      end

      def create_migration
        stamp =  Time.now.utc.strftime("%Y%m%d%H%M%S")
        template 'migration.rb', "db/migrate/#{stamp}_create_spree_#{plural_name}.rb"
      end

      def create_locale
        %w(en it).each do |locale|
          template "locales/#{locale}.yml", "config/locales/#{locale}_#{plural_name}.yml"
        end
      end

      def create_deface_override
        template 'overrides/add_to_admin_menu.rb', "app/overrides/spree/admin/add_spree_#{plural_name}_to_admin_menu.rb"
      end

      def create_routes
        append_file 'config/routes.rb', routes_text
      end

      protected
        def sortable?
          self.attributes.find { |a| a.name == 'position' && a.type == :integer }
        end

      private
        def routes_text
          if sortable?
<<-eos
Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :#{plural_name} do
      collection do
        post :update_positions
      end
    end
  end
end
eos
          else
<<-eos
Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :#{plural_name}
  end
end
eos
          end
        end
    end
  end
end