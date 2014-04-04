Deface::Override.new(:virtual_path => 'spree/admin/shared/_menu',
                     :name => 'add_<%= model_path %>_to_admin_menu',
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => '<%%= tab(:<%= model_name.pluralize %>) %>',
                     :disabled => false)
