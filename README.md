# Python Flask Application with CI/CD Pipeline

This repository contains a simple Flask application that provides addition functionality, with a complete CI/CD pipeline implemented using Jenkins and Docker.

## Project Overview

This is a simple RESTful API built with Flask that provides:
- A "Hello, World!" greeting at the root endpoint
- An `/add` endpoint that accepts two numbers and returns their sum

The project includes a complete DevOps setup with:
- Dockerized application
- Jenkins pipeline for CI/CD
- Automated testing
- Deployment to Docker Hub

## Prerequisites

Before setting up this application, ensure you have the following installed:
- Docker
- Jenkins
- Git
- Python
- Java
- cURL

A setup script (`script.sh`) is included in this repository to help install all prerequisites on an Amazon Linux instance.

## Setup Instructions

### 1. Environment Setup

Run the included setup script to install all prerequisites:

```bash
chmod +x script.sh
sudo ./script.sh
```

This script installs:
- Java 17 (Amazon Corretto)
- Jenkins
- Docker
- Python
- Git
- cURL

It also configures proper permissions by adding the `ec2-user` and `jenkins` users to the `docker` group.

### 2. Jenkins Configuration

After installing Jenkins:

1. Access the Jenkins web interface (default: http://localhost:8080)
2. Install suggested plugins
3. Create an admin user
4. Add Docker Hub credentials:
   - Go to "Manage Jenkins" > "Manage Credentials"
   - Add credentials with ID `DOCKER_LOGIN_CREDS`
   - Use your Docker Hub username and password/token

### 3. Running the Application Locally

To run the application locally without Jenkins:

```bash
# Clone the repository
git clone https://github.com/sarthak9876/python-code-jenkins-deploy.git
cd python-code-jenkins-deploy

# Build and run the Docker container
docker build -t flask-app .
docker run -d -p 5000:5000 --name flask_app flask-app
```

## Application Structure

- `app.py` - The main Flask application
- `requirements.txt` - Python dependencies
- `Dockerfile` - Instructions for building the Docker image
- `Jenkinsfile` - CI/CD pipeline configuration
- `script.sh` - Environment setup script

## API Endpoints

### Home
- URL: `/`
- Method: GET
- Response: "Hello, World!"

### Addition
- URL: `/add`
- Method: GET
- Parameters: 
  - `num1`: First number (required)
  - `num2`: Second number (required)
- Response: Sum of num1 and num2

Example:
```
GET /add?num1=5&num2=3
Response: 8
```

## CI/CD Pipeline

The Jenkins pipeline performs the following steps:
1. Prepares the workspace by removing any existing repository
2. Clones the repository
3. Builds a Docker image locally
4. Pushes the Docker image to Docker Hub
5. Runs the container locally
6. Executes automated tests against the API
7. Cleans up resources

## Docker

The application is containerized using Docker:
- Based on the lightweight Python 3.9 image
- Exposes port 5000
- Installs dependencies from requirements.txt
- Runs the Flask application

## Testing

The pipeline includes automated testing that validates the `/add` endpoint's functionality by sending a request and verifying the response.

## Contributing

To contribute to this project:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

[Specify your license here]
