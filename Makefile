# Makefile

.PHONY: run
.PHONY: docker/build docker/push docker/run docker/stop
.PHONY: api/get api/get/users
.PHONY: .pre-commit

REGISTRY = localhost:5000
MANIFESTS_DIR = k8s-manifests


# run from command line
#
run:
	node src/app.js

# --- build & run

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

# --- kubernetes

kube/apply:
	kubectl apply -f $(MANIFESTS_DIR)/minijs-deployment.yaml
	kubectl apply -f $(MANIFESTS_DIR)/minijs-service.yaml

kube/delete:
	kubectl delete deployment minijs
	kubectl delete service minijs

# --- call API

api/get:
	http http://127.0.0.1:3000

api/get/users:
	http http://127.0.0.1:3000/users

# --- other

.pre-commit:
	pre-commit run --all-files
