PHONY: help
.DEFAULT_GOAL := help

## Select the label used to build the images
LABEL=odiadom

## Set up images version
GRAFANA_VERSION_MAYOR=4
GRAFANA_VERSION_FULL=4.6.3

## Set up Grafana host port
HOST_PORT=3000

build: ## Build Grafana image
	@echo "Building GRAFANA ${GRAFANA_VERSION_MAYOR} docker image...";
	@echo "Full version is << ${GRAFANA_VERSION_FULL} >>";
	@echo "=========================================================";
	@cd grafana; docker build -t ${LABEL}/grafana:${GRAFANA_VERSION_FULL} .;
	
run: ## Run the Grafana container
	@echo "Running Grafana with default options";
	@docker stop grafana || true && docker rm grafana || true
	@docker run -d --name grafana -p ${HOST_PORT}:3000 ${LABEL}/grafana:${GRAFANA_VERSION_FULL} 
	
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


