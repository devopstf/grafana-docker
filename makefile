PHONY: help
.DEFAULT_GOAL := help

## Select the label used to build the images
LABEL=odiadom

## Set up images version
GRAFANA_VERSION_MAYOR=4
GRAFANA_VERSION_FULL=4.6.3

## Set up Grafana container name
GRAFANA_CONTAINER_NAME=grafana

## Set up Grafana persistence folder naming
GRAFANA_PERSISTENCE_NAME=grafana-persistence
GRAFANA_PERSISTENCE_LOCATION=/var/lib/docker/volumes/${GRAFANA_PERSISTENCE_NAME}/_data

## Set up Grafana host port
HOST_PORT=3000

build: ## Build Grafana image
	@echo "Building GRAFANA ${GRAFANA_VERSION_MAYOR} docker image...";
	@echo "Full version is << ${GRAFANA_VERSION_FULL} >>";
	@echo "=========================================================";
	@cd grafana; docker build -t ${LABEL}/grafana:${GRAFANA_VERSION_FULL} .;
	
run: ## Run the Grafana container
	@echo "Running Grafana with default options";
	@docker stop ${GRAFANA_CONTAINER_NAME} || true && docker rm ${GRAFANA_CONTAINER_NAME} || true
	@docker run -d --name ${GRAFANA_CONTAINER_NAME} -p ${HOST_PORT}:3000 ${LABEL}/grafana:${GRAFANA_VERSION_FULL} 
	
run-persistence:
        @echo "Running Grafana with data persistence in ${GRAFANA_PERSISTENCE_LOCATION}"
	@docker stop ${GRAFANA_CONTAINER_NAME} || true && docker rm ${GRAFANA_CONTAINER_NAME} || true
	@docker run -d --name ${GRAFANA_CONTAINER_NAME} -v ${GRAFANA_PERSISTENCE_NAME}:/usr/share/grafana/data -p ${HOST_PORT}:3000 ${LABEL}/grafana:${GRAFANA_VERSION_FULL} 
	
run-no-detach: ## Run the Grafana container without -d parameter to check on logs
        @echo "Running Prometheus without detach to check on logs at startup ..."
	@docker stop ${GRAFANA_CONTAINER_NAME} || true && docker rm ${GRAFANA_CONTAINER_NAME} || true
        @docker run --name ${GRAFANA_CONTAINER_NAME} -p ${HOST_PORT}:9090 ${LABEL}/grafana:${PROMETHEUS_VERSION_FULL}
        
logs: ## Show Grafana logs
        @echo "Printing Grafana logs ..."
        @docker logs ${GRAFANA_CONTAINER_NAME}
        
inspect: ## Checks Docker container with 'docker inspect'
        @echo "Checking out Docker container parameters"
        @docker inspect ${GRAFANA_CONTAINER_NAME}
	
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


