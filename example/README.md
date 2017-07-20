# Example Application

## TL;DR

```bash
$ kubectl create -f https://raw.githubusercontent.com/bitnami/bitnami-docker-node/master/example/kubernetes.yml
```

## Introduction

This example demostrates the use of the `bitnami/node` image to create a production build of your node application.

For demonstration purposes we'll bootstrap a [ExpressJS](https://expressjs.com) application, build a image with the tag `bitnami/node-example` and deploy it on a [Kubernetes](https://kubernetes.io) cluster.

## Generate the application

The example application is an [ExpressJS](https://expressjs.com) application bootstrapped using [express-generator](https://www.npmjs.com/package/express-generator).

```bash
$ express --git --css less example/
```

## Build and Test

To build a production Docker image of our application we'll use the `bitnami/node:6-prod` image, which is a production build of the Bitnami Node Image optimized for size.

```dockerfile
FROM bitnami/node:6-prod

ENV NODE_ENV="production"

COPY . /app

WORKDIR /app

RUN npm install

CMD ["npm", "start"]
```

We use the above `Dockerfile` to `COPY` the example application at the `/app` path of the container and install the npm module dependencies with the command `npm install`. Finally the Express application is start with `npm start`.

To build the Docker image, execute the command:

```bash
$ docker build -t bitnami/node-example:0.0.1 example/
```

Since the `bitnami/node:6-prod` image is optimized for production deployments it does not include any packages that would bloat the image.

```console
$ docker image ls
REPOSITORY                          TAG                    IMAGE ID            CREATED             SIZE
bitnami/node-example                0.0.1                  0d43bbca1cd2        22 seconds ago      193MB
```

You can now launch and test the image locally.

```console
$ docker run -it --rm -p 3000:3000 bitnami/node-example:0.0.1

> example@0.0.1 start /app
> node ./bin/www
```

Finally, push the image to the Docker registry

```bash
$ docker push bitnami/node-example:0.0.1
```

## Deployment

The `kubernetes.yml` file from the `example/` folder can be used to deploy our `bitnami/node-example:0.0.1` image to a Kubernetes cluster.

Simply download the Kubernetes manifest and create the Kubernetes resources described in the manifest using the command:

```console
$ kubectl create -f kubernetes.yml
service "example-svc" created
configmap "example-configmap" created
persistentvolumeclaim "example-data-pvc" created
deployment "example-deployment" created
```

From the output of the above command you will notice that we create the following resources:

 - [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
 - [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
 - [Volume](https://kubernetes.io/docs/concepts/storage/volumes/)
    + [ConfigMap](https://kubernetes.io/docs/concepts/storage/volumes/#projected)
    + [PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/volumes/#persistentvolumeclaim)

> **Note**
>
> Our example application is stateless and does not store any data or does not require any user configurations. As such we do not need to create the `ConfigMap` or `PersistentVolumeClaim` resources.
>
> In our `kubernetes.yml`, these resources are not utilized by our deployment and are strictly created to demostrate how they are declared in the manifest.

The `example-svc` is defined to be of `type: LoadBalancer`. You should be able to access the application via endpoints exposed by the service. Use the command `kubectl get svc` to get the IP address of the `example-svc` service. If you are using `minikube`, you can use the command `minikube service example-svc` to access the application.
