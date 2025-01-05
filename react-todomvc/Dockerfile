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
