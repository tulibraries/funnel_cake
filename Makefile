.PHONY: up check

up: check
	cp .env.dev .env
	bundle install
	bundle exec rake db:seed
	bundle exec rake db:migrate
	bundle exec rails s -p 3000

check:
ifndef SOLR_IP
		$(error SOLR_IP is undefined)
endif
