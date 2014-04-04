Spree::Core::Engine.add_routes do
  namespace :admin do
    resources <%= model_name.to_sym %>
  end
end