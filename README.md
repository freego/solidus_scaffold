SpreeScaffold
=============

A basic admin scaffold generator for Spree.

Creates a CRUD interface for your models inside Spree admin.

Installation
============

Add this line to your application's Gemfile:
```ruby
gem 'spree_scaffold', github: 'freego/spree_scaffold', branch: '2-2-stable'
```

And then execute:

    $ bundle

Usage
=====

Generate a scaffold for the new `Brand` model:

    $ rails g spree_scaffold:scaffold Brand name:string description:text

Output:

    create  app/models/spree/brand.rb
    create  app/controllers/spree/admin/brands_controller.rb
    create  app/views/spree/admin/brands/index.html.erb
    create  app/views/spree/admin/brands/new.html.erb
    create  app/views/spree/admin/brands/edit.html.erb
    create  app/views/spree/admin/brands/_form.html.erb
    create  db/migrate/20140404065541_create_spree_brands.rb
    create  config/locales/en_spree_brands.yml
    create  app/overrides/spree/admin/add_spree_brands_to_admin_menu.rb
    append  config/routes.rb

Then run the migration:

    $ rake db:migrate

To rollback:

    $ rake db:rollback
    $ rails d spree_scaffold:scaffold Brand


Copyright (c) 2014 sebastyuiop, alepore, released under the New BSD License