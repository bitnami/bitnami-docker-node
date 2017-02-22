[![CircleCI](https://circleci.com/gh/bitnami/bitnami-docker-node/tree/master.svg?style=shield)](https://circleci.com/gh/bitnami/bitnami-docker-node/tree/master)
[![Docker Hub Automated Build](http://container.checkforupdates.com/badges/bitnami/node)](https://hub.docker.com/r/bitnami/node/)

# Supported tags and respective `Dockerfile` links

- [`7`](https://github.com/bitnami/bitnami-docker-node/blob/83a944588f3654d5cf9566a58f01682e48de4605/7/Dockerfile) [`7.6.0-r0`](https://github.com/bitnami/bitnami-docker-node/blob/83a944588f3654d5cf9566a58f01682e48de4605/7/Dockerfile) [`latest`](https://github.com/bitnami/bitnami-docker-node/blob/83a944588f3654d5cf9566a58f01682e48de4605/7/Dockerfile)
- [`6`](https://github.com/bitnami/bitnami-docker-node/blob/2ec4d3be4b03d4f40142089d9965af6f8d6f8efb/6/Dockerfile) [`6.10.0-r0`](https://github.com/bitnami/bitnami-docker-node/blob/2ec4d3be4b03d4f40142089d9965af6f8d6f8efb/6/Dockerfile)
- [`4`](https://github.com/bitnami/bitnami-docker-node/blob/b91bacae1ae31d0ff5af6f4adef7d7ce80ee2901/4/Dockerfile) [`4.8.0-r0`](https://github.com/bitnami/bitnami-docker-node/blob/b91bacae1ae31d0ff5af6f4adef7d7ce80ee2901/4/Dockerfile)

Subscribe to project updates by watching the [bitnami/node GitHub repo](https://github.com/bitnami/bitnami-docker-node).

# What is Node.js?

> Node.js is a platform built on Chrome's JavaScript runtime for easily building fast, scalable network applications. Node.js uses an event-driven, non-blocking I/O model that makes it lightweight and efficient, perfect for data-intensive real-time applications that run across distributed devices.

[nodejs.org](https://nodejs.org/)

# TLDR

```bash
docker run -it --name node bitnami/node
```

## Docker Compose

```yaml
node:
  image: bitnami/node
  command: npm start
  volumes:
    - .:/app
```

# Get this image

The recommended way to get the Bitnami Node.js Docker Image is to pull the prebuilt image from the [Docker Hub Registry](https://hub.docker.com/r/bitnami/node).

```bash
docker pull bitnami/node:latest
```

To use a specific version, you can pull a versioned tag. You can view the [list of available versions](https://hub.docker.com/r/bitnami/node/tags/) in the Docker Hub Registry.

```bash
docker pull bitnami/node:[TAG]
```

If you wish, you can also build the image yourself.

```bash
docker build -t bitnami/node https://github.com/bitnami/bitnami-docker-node.git
```

# Entering the REPL

By default, running this image will drop you into the Node.js REPL, where you can interactively test and try things out in Node.js.

```bash
docker run -it --name node bitnami/node
```

**Further Reading:**

  - [nodejs.org/api/repl.html](https://nodejs.org/api/repl.html)

# Running your Node.js script

The default work directory for the Node.js image is `/app`. You can mount a folder from your host here that includes your Node.js script, and run it normally using the `node` command.

```bash
docker run -it --name node -v /path/to/app:/app bitnami/node \
  node script.js
```

# Running a Node.js app with npm dependencies

If your Node.js app has a `package.json` defining your app's dependencies and start script, you can install the dependencies before running your app.

```bash
docker run --rm -v /path/to/app:/app bitnami/node npm install
docker run -it --name node  -v /path/to/app:/app bitnami/node npm start
```

or using Docker Compose:

```yaml
node:
  image: bitnami/node
  command: "sh -c 'npm install && npm start'"
  volumes:
    - .:/app
```

**Further Reading:**

- [package.json documentation](https://docs.npmjs.com/files/package.json)
- [npm start script](https://docs.npmjs.com/misc/scripts#default-values)

# Accessing a Node.js app running a web server

By default the image exposes the port `3000` of the container. You can use this port for your Node.js application server.

Below is an example of an [express.js](http://expressjs.com/) app listening to remote connections on port `3000`:

```javascript
var express = require('express');
var app = express();

app.get('/', function (req, res) {
  res.send('Hello World!');
});

var server = app.listen(3000, '0.0.0.0', function () {

  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});
```

To access your web server from your host machine you can ask Docker to map a random port on your host to port `3000` inside the container.

```bash
docker run -it --name node -v /path/to/app:/app -P bitnami/node node index.js
```

Run `docker port` to determine the random port Docker assigned.

```bash
$ docker port node
3000/tcp -> 0.0.0.0:32769
```

You can also specify the port you want forwarded from your host to the container.

```bash
docker run -it --name node -p 8080:3000 -v /path/to/app:/app bitnami/node node index.js
```

Access your web server in the browser by navigating to [http://localhost:8080](http://localhost:8080/).

# Connecting to other containers

If you want to connect to your Node.js web server inside another container, you can use docker networking to create a network and attach all the containers to that network.

## Serving your Node.js app through an nginx frontend

We may want to make our Node.js web server only accessible via an nginx web server. Doing so will allow us to setup more complex configuration, serve static assets using nginx, load balance to different Node.js instances, etc.

### Step 1: Create a network

```bash
docker network create app-tier --driver bridge
```

or using Docker Compose:

```yaml
version: '2'

networks:
  app-tier:
    driver: bridge
```

### Step 2: Create a virtual host

Let's create an nginx virtual host to reverse proxy to our Node.js container.

```nginx
server {
    listen 0.0.0.0:80;
    server_name yourapp.com;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header HOST $http_host;
        proxy_set_header X-NginX-Proxy true;

        # proxy_pass http://[your_node_container_link_alias]:3000;
        proxy_pass http://myapp:3000;
        proxy_redirect off;
    }
}
```

Notice we've substituted the link alias name `myapp`, we will use the same name when creating the container.

Copy the virtual host above, saving the file somewhere on your host. We will mount it as a volume in our nginx container.

### Step 3: Run the Node.js image with a specific name

```bash
docker run -it --name myapp --network app-tier \
  -v /path/to/app:/app \
  bitnami/node node index.js
```

or using Docker Compose:

```yaml
version: '2'
myapp:
  image: bitnami/node
  command: node index.js
  networks:
    - app-tier
  volumes:
    - .:/app
```

### Step 4: Run the nginx image

```bash
docker run -it \
  -v /path/to/vhost.conf:/bitnami/nginx/conf/vhosts/yourapp.conf:ro \
  --network app-tier \
  bitnami/nginx
```

or using Docker Compose:

```yaml
version: '2'
nginx:
  image: bitnami/nginx
  networks:
    - app-tier
  volumes:
    - /path/to/vhost.conf:/bitnami/nginx/conf/vhosts/yourapp.conf:ro
```

# Maintenance

## Upgrade this image

Bitnami provides up-to-date versions of Node.js, including security patches, soon after they are made upstream. We recommend that you follow these steps to upgrade your container.

### Step 1: Get the updated image

```bash
docker pull bitnami/node:latest
```

or if you're using Docker Compose, update the value of the image property to `bitnami/node:latest`.

### Step 2: Remove the currently running container

```bash
docker rm -v node
```

or using Docker Compose:

```bash
docker-compose rm -v node
```

### Step 3: Run the new image

Re-create your container from the new image.

```bash
docker run --name node bitnami/node:latest
```

or using Docker Compose:

```bash
docker-compose start node
```

# Notable Changes

## 6.2.0-r0 (2016-05-11)

- Commands are now executed as the `root` user. Use the `--user` argument to switch to another user or change to the required user using `sudo` to launch applications. Alternatively, as of Docker 1.10 User Namespaces are supported by the docker daemon. Refer to the [daemon user namespace options](https://docs.docker.com/engine/reference/commandline/daemon/#daemon-user-namespace-options) for more details.

## 4.1.2-0 (2015-10-12)

- Permissions fixed so `bitnami` user can install global npm modules without needing `sudo`.

## 4.1.1-0-r01 (2015-10-07)

- `/app` directory is no longer exported as a volume. This caused problems when building on top of the image, since changes in the volume are not persisted between Dockerfile `RUN` instructions. To keep the previous behavior (so that you can mount the volume in another container), create the container with the `-v /app` option.

# Contributing

We'd love for you to contribute to this Docker image. You can request new features by creating an [issue](https://github.com/bitnami/bitnami-docker-node/issues), or submit a [pull request](https://github.com/bitnami/bitnami-docker-node/pulls) with your contribution.

# Issues

If you encountered a problem running this container, you can file an [issue](https://github.com/bitnami/bitnami-docker-node/issues). For us to provide better support, be sure to include the following information in your issue:

- Host OS and version
- Docker version (`docker version`)
- Output of `docker info`
- Version of this container (`echo $BITNAMI_IMAGE_VERSION` inside the container)
- The command you used to run the container, and any relevant output you saw (masking any sensitive
information)

# License

Copyright (c) 2015-2016 Bitnami

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
