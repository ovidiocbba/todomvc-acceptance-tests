# Use OpenJDK 23 slim as the base image
FROM openjdk:23-slim

# Set the working directory inside the container
WORKDIR /tests

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
CMD ["./gradlew", "test"]