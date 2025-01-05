# Table of contents

- [Basic Docker Commands](#basic-docker-commands)
- [Creating Your First Docker Image](#creating-your-first-docker-image)
- [Running the TodoMVC application with Docker](#running-the-todomvc-application-with-docker)
- [Running the Playwright Tests with Docker](#running-the-playwright-tests-with-docker)
 
## Basic Docker Commands

### 1. Check Docker Version
```bash
docker --version
```
Output:
```
Docker version 27.3.1, build ce12230
```
### 2. Run the Hello World Container
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
### 3. List Docker Images
This command lists all Docker images available locally on your system.  
Each image represents a snapshot that can be used to create containers
```bash
docker images
```
```
REPOSITORY                        TAG       IMAGE ID       CREATED         SIZE
hello-world                       latest    5b3cc85e16e3   20 months ago   24.4kB
```
### 4. Pull a Specific Docker Image Version
Downloads the specified image from Docker Hub.
```bash
docker pull nginx:1.24
```
### 5. Pull the Latest Docker Image
```bash
docker pull nginx:latest
```
## Creating Your First Docker Image
### 1. Go to directory
```bash
cd docker-web-demo
```
### 2. Create a "Dockerfile"
```dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
```
The Dockerfile:
   1. Uses ``nginx:latest`` as the base image, which comes with a pre-installed and configured ``Nginx server``.
   2. This line copies a local file called ``index.html`` (which must be in the same directory as the Dockerfile) to the container.
      The file is placed in the ``/usr/share/nginx/html/`` directory, which is the default location where ``Nginx`` looks for files to serve as web content.
    ```dockerfile
    COPY index.html /usr/share/nginx/html/index.html
    ```
### 3. Build the Docker Image  
```bash
docker build -t my-nginx-demo .
```
This command builds a Docker image from a Dockerfile located in the current directory (.).  
**docker build:** This is the command used to build a Docker image.
**-t my-nginx-demo**: The **-t** flag tags the image with a name (**my-nginx-demo**).  
**.**: The period represents the current directory, where **Docker** _**will look for the Dockerfile**_ to build the image.

### 4. Run the Docker Container
```bash
docker run -d -p 8080:80 --name web-demo my-nginx-demo
```
This command runs a Docker container based on the my-nginx-demo image with several specified options.  
**docker run**: This is the command to ``run a Docker container`` from ``an image``.  
**-d**: Detached mode (**runs the container in the background**).  
**-p 8080:80**: **Maps port 8080 on your local machine** to port 80 inside the container.  
**--name web-demo**: Assigns the name ``web-demo`` to the container.  
**my-nginx-demo**: Specifies the ``image`` to use for the container.  

### 5. Access the Web Page in Your Browser
Open your web browser and visit:  
```bash
http://localhost:8080/
```
Visiting http://localhost:8080/ will display the custom web page being served by the ``Nginx container``, based on the ``index.html`` file **you added to the image**.
![Local Image](images/web-demo.png)
### 6.Stop a Running Docker Container
```bash
docker stop web-demo
```
This command is used to stop a running Docker container.  
**docker stop**: This is the command to ``stop a running container``.  
**web-demo**: The ``name of the container to stop``. In this case, it refers to the container that was started with the name web-demo.

### 7. List Running Docker Containers
```bash
docker ps
```
This command shows a list of all currently running ``Docker containers``.
**docker ps**: Lists the running containers on your system. By default, it **only shows containers that are actively running**.
### 8. Remove a Stopped Docker Container
```bash
docker rm web-demo
```
This command removes a stopped Docker container from your system.  
**docker rm**: This command removes one or more containers from your system.
**web-demo**: The **name of the container to remove**, in this case, the ``web-demo container``.
  <div align="right">
      <b><a href="#table-of-contents">↥ Back to top</a></b>
  </div>

## Running the TodoMVC application with Docker
### 1. Go to directory
```bash
cd ../react-todomvc
```

### 2. Create a "Dockerfile"
```dockerfile
# Uses the official Node.js image, version 16, as the base image.
FROM node:16

# Creates and sets "/app" as the directory where all subsequent commands will be executed.
WORKDIR /app

# Copies the package.json and package-lock.json files from the host machine to the current directory (./) in the container.
COPY package*.json ./

# Prepares the application environment by installing all necessary libraries and dependencies.
RUN npm install

# Copies all files and folders from the 'host machine's current' directory to the 'container's current directory' (/app).
COPY . .

# Declares that the container will use port 7002.
EXPOSE 7002

# Launches the application. This assumes the serve script is defined in the package.json file and typically starts the application server
CMD ["npm", "run", "serve"]
```
### 3. Build a Docker Image
Creates an image named ``todomvc-app``, which can be used to run containers.
```bash
docker build -t todomvc-app .
```
### 4. Run a Container with the Application
This command starts a container based on the ``todomvc-app`` image and maps port ``7002`` from the container to port 7002 **on the host machine**.  
```bash
docker run -p 7002:7002 todomvc-app
```
### 5. Access the Web Page in Your Browser
Open your web browser and visit:
```bash
http://localhost:7002/
```
Visiting http://localhost:7002/ will display the custom web page being served by the ``Nginx container``, based on the ``index.html`` file **you added to the image**.
![Local Image](images/todomvc-app.png)

### 6. Execute Tests Locally for the todomvc-acceptance-tests Project
1. **Navigate to the Project Directory:**
Ensure you're in the root directory of the ``todomvc-acceptance-tests`` project.
2. **Execute the Tests:**  
```bash
gradle clean test
``` 
![Local Image](images/execute-tests-locally.png)

  <div align="right">
      <b><a href="#table-of-contents">↥ Back to top</a></b>
  </div>

## Running the Playwright Tests with Docker
### 1. Go to directory(``todomvc-acceptance-tests``)
```bash
cd ..
```

### 2. Create a "Dockerfile"
```dockerfile
# Use OpenJDK 23 slim as the base image
FROM openjdk:23-slim

# Set the working directory inside the container
WORKDIR /app

# Install dependencies required for Playwright
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    ca-certificates \
    unzip \
    && apt-get clean

# Install Node.js and npm, playwright and compatible browsers
RUN mkdir -p /usr/local/playwright && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g playwright && \
    npx playwright install && \
    npx playwright install-deps

# Copy project files (assuming the Dockerfile is in the same directory as the project)
COPY . .

# Build the project using Gradle (skip tests during build)
RUN ./gradlew clean build -x test

# Command to run the test cases using JUnit5
CMD ["./gradlew", "clean", "test", "--rerun-tasks"]
```
### 3. Build a Docker Image for Playwright Tests
Creates a Docker image named ``playwright-tests`` containing all the dependencies, tools, and project files necessary to run Playwright tests.
```bash
docker build -t playwright-tests .
```
### 4. Run Playwright Tests in a Docker Container
This command runs **a container** from the ``playwright-tests image`` and connects it to the ``host network`` for improved network access.
```bash
docker run --network host playwright-tests
```
![Local Image](images/run-tests-in-a-docker-container.png)
**Note:**
Before running the tests, ensure that the application (**todomvc-app**) is ``running locally`` so the Playwright tests can interact with it. You can start the application using the following command:  
```bash
docker run -p 7002:7002 todomvc-app
```
  <div align="right">
      <b><a href="#table-of-contents">↥ Back to top</a></b>
  </div>
