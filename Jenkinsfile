pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/sarthak9876/python-code-jenkins-deploy.git'
        DOCKER_IMAGE = 'mysteryman0007/python-code-jenkins'
        DOCKER_TAG='latest'
        //DOCKER_REPO = 'mysteryman0007/python-code-jenkins'
        DOCKER_CREDENTIALS_ID = 'DOCKER_LOGIN_CREDS' // The ID of the Docker credentials in Jenkins
    }

    stages {
        stage('Preparing the WS'){
            steps{
                script{
                    if(fileExists('python-code-jenkins-deploy')){
                        sh 'rm -rf python-code-jenkins-deploy;
                    }
                }
            }
        }

        stage('Cloning the Repository') {
            steps {
                script {
                    // Clone the repository
                    sh 'git clone ${REPO_URL}'
                }
            }
        }

        stage('Building the Docker Image Locally') {
            steps {
                script {
                    // Navigate to the app directory and build the Docker image
                    sh '''
                    cd python-code-jenkins-deploy
                    docker build -t ${DOCKER_IMAGE} .
                    '''
                }
            }
        }

        stage('Push the Docker Image to Repository') {
            steps {
                script {
                    // Login to the Docker repository
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin ${DOCKER_REPO}
                        docker tag ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${DOCKER_TAG}
                        docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                        '''
                    }
                }
            }
        }

        stage('Running the Container Locally') {
            steps {
                script {
                    // Run the Docker container
                    sh '''
                    docker run -d -p 5000:5000 --name flask_app ${DOCKER_IMAGE}
                    sleep 10 # Wait for the container to start
                    '''
                }
            }
        }

        stage('Running Automated Tests') {
            steps {
                script {
                    // Write and execute the test script
                    writeFile file: 'test_api.sh', text: '''
                    #!/bin/bash
                    response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"num1": 1, "num2": 2}' http://localhost:5000/add)
                    if [[ "$response" == '{"result":3}' ]]; then
                        echo "Test Passed"
                        exit 0
                    else
                        echo "Test Failed"
                        exit 1
                    fi
                    '''
                    sh 'chmod +x test_api.sh'
                    sh './test_api.sh'
                }
            }
        }

        stage('Cleaning Up') {
            steps {
                script {
                    // Clean up Docker images and Jenkins workspace
                    sh '''
                    docker stop flask_app
                    docker rm flask_app
                    docker rmi ${DOCKER_IMAGE}
                    docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG}
                    '''
                    cleanWs()
                }
            }
        }
    }
}
