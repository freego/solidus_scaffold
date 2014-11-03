module Spree
  class <%= class_name %> < ActiveRecord::Base
<% if slugged? -%>
    extend FriendlyId
    friendly_id :slug_candidates, use: [:slugged, :finders]
<% end -%>
<% attributes.each do |attribute| -%>
<% if attribute.type == :image -%>
    has_attached_file :<%= attribute.name %>,
                      styles: { large: '600x600>' },
                      default_style: :large,
                      url: '/spree/<%= plural_name %>/:id/:style/:basename.:extension',
                      path: ':rails_root/public/spree/<%= plural_name %>/:id/:style/:basename.:extension',
                      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }

    validates_attachment :<%= attribute.name %>, content_type: { content_type: /\Aimage\/.*\Z/ }
<% elsif attribute.type == :file -%>
    has_attached_file :<%= attribute.name %>,
                      url: '/spree/<%= plural_name %>/:id/:basename.:extension',
                      path: ':rails_root/public/spree/<%= plural_name %>/:id/:basename.:extension'
<% end -%>
<% end -%>
<% if slugged? -%>
    def slug_candidates
      [:<%= attributes.find { |a| a.type == :string }.name %>]
    end
<% end -%>
  end
end