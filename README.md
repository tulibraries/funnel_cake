# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

Under the hood, that command uses [traject](https://github.com/traject/traject), with hard coded defaults. If you need to override a default to ingest your data, You can call traject directly:

``` bash
bundle exec traject -i xml -c combine_indexer.rb [path/to/combine_data.xml]
```


* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
