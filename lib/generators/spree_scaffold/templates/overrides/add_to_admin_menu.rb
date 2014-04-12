Deface::Override.new(:virtual_path => 'spree/admin/shared/_menu',
                     :name => 'add_<%= plural_name %>_to_admin_menu',
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => '<%%= tab(:<%= plural_name %>) %>',
                     :disabled => false)
