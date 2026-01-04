pipeline {
    agent any

    environment {
        IMAGE_NAME = "bhavadesh/react-devops-app"
        DOCKER_TAG = "latest"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Cloning GitHub repository...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh '''
                  chmod +x build.sh
                  ./build.sh
                '''
            }
        }

        stage('Deploy Application') {
            steps {
                echo 'Deploying application using docker-compose...'
                sh '''
                  chmod +x deploy.sh
                  ./deploy.sh
                '''
            }
        }
    }

    post {
        success {
            echo '✅ CI/CD Pipeline executed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs.'
        }
    }
}
