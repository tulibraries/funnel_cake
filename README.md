# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

To create the Blacklight Ruby on Rails application database, issue the command:

    bundle exec rails db:migrate

To create the Solr database, issue the command:

    bundle exec rails solr:install

And start Solr

    solr_wrapper &

* Database initialization

Download the combine xml data with wget, and rename it to something more readable.

    wget --output-document=combine_data.xml http://66.228.32.56/combine/oai?verb=ListRecords&set=test_publish_1

Under the hood, that command uses [traject](https://github.com/traject/traject), with hard coded defaults. If you need to override a default to ingest your data, You can call traject directly:

    bundle exec traject -i xml -c combine_indexer.rb [path/to/combine_data.xml]

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

To start Blacklight, start a rails server

    bundle exec rails server

In a web browser visit http://localhost:8983 to access the Solr web interface
or http://localhost:3000 to access the Blacklight application

* Deployment instructions

* ...
