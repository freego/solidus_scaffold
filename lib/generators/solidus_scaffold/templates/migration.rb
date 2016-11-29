class CreateSpree<%= class_name.pluralize %> < ActiveRecord::Migration
  def self.up
    create_table :spree_<%= table_name %> do |t|
<% attributes.each do |attribute| -%>
<% next if attribute.type == :image || attribute.type == :file -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>
<% unless options[:skip_timestamps] -%>
      t.timestamps
<% end -%>
    end
  end

  def self.down
    drop_table :spree_<%= table_name %>
  end
end