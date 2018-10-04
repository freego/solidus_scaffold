# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_scaffold'
  s.version     = '1.0.0'
  s.summary     = 'Easily integrate your model in Solidus admin interface'
  s.description = s.summary
  s.required_ruby_version = '>= 2.1.0'

  s.author    = 'Seb Weston, Alessandro Lepore'
  s.email     = 'a.lepore@freegoweb.it'

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'solidus_backend', '~> 2.0'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
