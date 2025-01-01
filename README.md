# MiniJS

Minimalistic app based on ExpressJS to play with Kubernetes.

## Docker container

Use the following commands to build & run the Docker container:

    $ make docker/build
    $ make docker/run
    $ make api/get
    $ make docker/stop

Kubernetes takes its images from a registry. To setup a local registry and push
the image:

    $ docker run -d -p 5000:5000 --restart=always --name registry registry:2
    $ docker build . -t localhost:5000/minijs
    $ docker push localhost:5000/minijs

## Kubernetes

Take images from the local registry:

      containers:
        - name: minijs
          image: localhost:5000/minijs
          imagePullPolicy: IfNotPresent

Access minijs service:

    $ kubectl get node -o wide |awk '{print $6}'
    INTERNAL-IP
    198.19.249.2

    $ curl -I 198.19.249.2:30001

or simply:

    $ curl -I localhost:30001

Validate yaml files with Kubernetes:

    $ kubectl apply --validate=true --dry-run=client -f deployment.yaml
    deployment.apps/minijs created (dry run)
    service/minijs created (dry run)

Delete all resources in a namespace:

    $ kubectl delete all--all -n ingress-nginx
    $ # or individually:
    $ kubectl delete ingress ingress-nginx
    $ kubectl delete deployment ingress-nginx
    $ kubectl delete service ingress-nginx

    $ kubectl delete deployment my-app
    $ kubectl delete service my-app

Scale deployments:

    $ kubectl get rs
    $ kubectl scale deployments/minijs --replicas=4
    $ kubctl get deployments

See: [scale intro](https://kubernetes.io/docs/tutorials/kubernetes-basics/scale/scale-intro/).

### Postgres

Connect to database:

    kubectl exec -it postgres-75fdf7fcdd-h59pd -- \
        psql \
            -h localhost \
            -U postgres \
            --password \
            -p 5432 \
            postgres
