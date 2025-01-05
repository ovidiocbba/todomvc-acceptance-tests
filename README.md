Basic Docker Commands

### Check Docker Version
```bash
docker --version
```
Output:
```
Docker version 27.3.1, build ce12230
```
### Run the Hello World Container
```bash
docker run hello-world
```
Output:
```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```
### List Docker Images
This command lists all Docker images available locally on your system.  
Each image represents a snapshot that can be used to create containers
```bash
docker images
```
```
REPOSITORY                        TAG       IMAGE ID       CREATED         SIZE
hello-world                       latest    5b3cc85e16e3   20 months ago   24.4kB
```
### Pull a Specific Docker Image Version
Downloads the specified image from Docker Hub.
```bash
docker pull nginx:1.24
```
### Pull the Latest Docker Image
```bash
docker pull nginx:latest
```