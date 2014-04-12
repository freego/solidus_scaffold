Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :<%= plural_name %>
  end
end