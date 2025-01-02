# Makefile

.PHONY: docker/build docker/push docker/run docker/stop
.PHONY: api/get
.PHONY: .pre-commit

REGISTRY = localhost:5000
MANIFESTS_DIR = k8s-manifests

# build & run

# Build image
#
# Alternative using Docker Compose:
#    docker compose up --build
#
docker/build:
	docker build . -t $(REGISTRY)/minijs

docker/push:
	docker push $(REGISTRY)/minijs

docker/run:
	docker run --rm -d -p 3000:3000 --name minijs-app $(REGISTRY)/minijs

docker/stop:
	docker stop minijs-app

# kubernetes

kube/apply:
	kubectl apply -f $(MANIFESTS_DIR)/minijs-deployment.yaml
	kubectl apply -f $(MANIFESTS_DIR)/minijs-service.yaml

kube/delete:
	kubectl delete deployment minijs
	kubectl delete service minijs

# call API

api/get:
	http http://127.0.0.1:3000

# other

.pre-commit:
	pre-commit run --all-files
