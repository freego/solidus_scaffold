module Spree
  class <%= class_name %> < ActiveRecord::Base
    <% attributes.each do |attribute| %>
    <% if attribute.type == :image %>
    has_attached_file :<%= attribute.name %>,
                      styles: { large: '600x600>' },
                      default_style: :large,
                      url: '/spree/<%= plural_name %>/:id/:style/:basename.:extension',
                      path: ':rails_root/public/spree/<%= plural_name %>/:id/:style/:basename.:extension',
                      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
    <% elsif attribute.type == :file %>
    has_attached_file :<%= attribute.name %>,
                      url: '/spree/<%= plural_name %>/:id/:basename.:extension',
                      path: ':rails_root/public/spree/<%= plural_name %>/:id/:basename.:extension'
    <% end %>
    <% end %>
  end
end