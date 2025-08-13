pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'jehp/newpro:latest'  // Modify this to your Docker Hub username/repo
        DOCKER_REGISTRY = 'docker.io'          // Use your private Docker registry URL
        K8S_CLUSTER = 'minikube'               // Minikube Kubernetes cluster
    }

    stages {
        stage('Cloning the Repository') {
            steps {
                // Clone the repository containing your Flask app
                git 'https://github.com/SatGitZ/newpro.git'
            }
        }

        stage('Building the Docker Image') {
            steps {
                script {
                    // Build the Docker image locally
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Running Automated Tests') {
            steps {
                script {
                    // Run tests inside the Docker container
                    sh ' chmod +x test_api.sh && ./test_api.sh'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login to Docker Registry
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }

                    // Push the Docker image to the private registry
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to Kubernetes Cluster') {
            steps {
                script {
                    // Deploy the app to Minikube Kubernetes cluster
                    sh 'kubectl apply -f k8s/deployment.yaml'
                }
            }
        }

        stage('Cleaning Up') {
            steps {
                script {
                    // Clean up local Docker images and Jenkins workspace
                    sh 'docker rmi ${DOCKER_IMAGE}'
                    deleteDir()
                }
            }
        }
    }
}
