up: down
	@echo "Building solr containers, networks, volumes"
	docker-compose pull
	docker-compose up --build -d
	@echo "solr running on http://localhost:8983"

update: load-collections
	@echo "Updating solr containers, networks, volumes"
	docker-compose up --build -d
	docker-compose restart

stop:
	@echo "Stopping solr containers, networks, volumes"
	docker-compose stop

down: stop
	@echo "Killing solr containers, networks, volumes"
	docker-compose rm -fv

load-collections:
	@echo "Cloning Configs into ./solrdata/solr-configs folder (mounted volume)"
	if [ ! -d "./solrdata/solr-configs" ]; then git clone https://github.com/tulibraries/solr-configs.git solrdata/solr-configs; fi
	@echo "Loading Configs into Solr"
	curl http://localhost:8983/admin/collections?action=CREATE&name=funcake&numShards=1&replicationFactor=1&maxShardsPerNode=1&collection.configName=funcake
