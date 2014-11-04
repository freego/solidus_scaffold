require 'rails/generators/named_base'

module SpreeScaffold
  module Generators
    class ScaffoldGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration

      source_root File.expand_path('../../templates', __FILE__)

      argument :attributes, type: :array, default: [], banner: 'field:type field:type'

      def self.next_migration_number(path)
        if @prev_migration_nr
          @prev_migration_nr = @prev_migration_nr += 1
        else
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        end
      end

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

      def create_migrations
        migration_template 'migration.rb', "db/migrate/create_spree_#{plural_name}.rb"
        migration_template 'migration_paperclip.rb', "db/migrate/create_spree_#{plural_name}_attachments.rb" if has_attachments?
      end

      def create_locale
        %w(en it).each do |locale|
          template "locales/#{locale}.yml", "config/locales/#{locale}_#{plural_name}.yml"
        end
      end

      def create_deface_override
        template 'overrides/add_to_admin_menu.html.erb.deface', "app/overrides/spree/admin/shared/_menu/add_spree_#{plural_name}.html.erb.deface"
      end

      def create_routes
        append_file 'config/routes.rb', routes_text
      end

      protected
        def sortable?
          self.attributes.find { |a| a.name == 'position' && a.type == :integer }
        end

        def has_attachments?
          self.attributes.find { |a| a.type == :image || a.type == :file }
        end

        def slugged?
          self.attributes.find { |a| a.name == 'slug' && a.type == :string }
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