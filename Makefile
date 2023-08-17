.PHONY: up check

#Defaults
include .env.prod
export #exports the .env.prod variables

IMAGE ?= tulibraries/padigital
VERSION ?= $(DOCKER_IMAGE_VERSION)
HARBOR ?= harbor.k8s.temple.edu
BASE_IMAGE ?= harbor.k8s.temple.edu/library/ruby:3.1-alpine
PLATFORM ?= linux/x86_64
CLEAR_CACHES ?= no
SECRET_KEY_BASE ?= $(PADIGITAL_SECRET_KEY_BASE)
CI ?= false
PADIGITAL_DB_HOST ?= host.docker.internal
PADIGITAL_DB_USER ?= postgres
SOLR_IP ?= localhost:8983

DEFAULT_RUN_ARGS ?= -e "EXECJS_RUNTIME=Disabled" \
		-e "K8=yes" \
		-e "RAILS_ENV=production" \
		-e "SECRET_KEY_BASE=$(SECRET_KEY_BASE)" \
		-e "RAILS_SERVE_STATIC_FILES=yes" \
		-e "PADIGITAL_DB_HOST=$(PADIGITAL_DB_HOST)" \
		-e "PADIGITAL_DB_PASSWORD=$(PADIGITAL_DB_PASSWORD)" \
		-e "PADIGITAL_DB_USER=$(PADIGITAL_DB_USER)" \
	  -e "SOLR_IP"=$(SOLR_IP) \
		-e "RAILS_LOG_TO_STDOUT=yes" \
		--rm -it

build:
	@docker build --build-arg RAILS_MASTER_KEY=$(RAILS_MASTER_KEY) \
		--build-arg SECRET_KEY_BASE=$(SECRET_KEY_BASE) \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--platform $(PLATFORM) \
		--progress plain \
		--tag $(HARBOR)/$(IMAGE):$(VERSION) \
		--tag $(HARBOR)/$(IMAGE):latest \
		--file .docker/app/Dockerfile \
		--no-cache .

run:
	@docker run --name=padigital -p 127.0.0.1:3001:3000/tcp \
		--platform $(PLATFORM) \
		$(DEFAULT_RUN_ARGS) \
		$(HARBOR)/$(IMAGE):$(VERSION)

lint:
	@if [ $(CI) == false ]; \
		then \
			hadolint .docker/app/Dockerfile; \
		fi

scan:
	@if [ $(CLEAR_CACHES) == yes ]; \
		then \
			trivy image --scanners vuln  -c $(HARBOR)/$(IMAGE):$(VERSION); \
		fi
	@if [ $(CI) == false ]; \
		then \
			trivy image --scanners vuln $(HARBOR)/$(IMAGE):$(VERSION); \
		fi

deploy: scan lint
	@docker push $(HARBOR)/$(IMAGE):$(VERSION) \
	# This "if" statement needs to be a one liner or it will fail.
	# Do not edit indentation
	@if [ $(VERSION) != latest ]; \
		then \
			docker push $(HARBOR)/$(IMAGE):latest; \
		fi

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
