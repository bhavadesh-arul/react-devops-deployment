pipeline {
    agent any

    environment {
        DOCKER_USER = "bhavadesh"
        DEV_REPO    = "react-devops-dev"
        PROD_REPO   = "react-devops-prod"
        IMAGE_TAG   = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
                sh 'git branch --show-current'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                echo "Building Docker image..."
                docker build -t ${DOCKER_USER}/react-app:${IMAGE_TAG} .
                '''
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh '''
                    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    '''
                }
            }
        }

        stage('Push Image (DEV)') {
            when {
                branch 'dev'
            }
            steps {
                sh '''
                echo "Pushing image to DEV repository..."
                docker tag ${DOCKER_USER}/react-app:${IMAGE_TAG} ${DOCKER_USER}/${DEV_REPO}:${IMAGE_TAG}
                docker tag ${DOCKER_USER}/react-app:${IMAGE_TAG} ${DOCKER_USER}/${DEV_REPO}:latest
                docker push ${DOCKER_USER}/${DEV_REPO}:${IMAGE_TAG}
                docker push ${DOCKER_USER}/${DEV_REPO}:latest
                '''
            }
        }

        stage('Push Image (PROD)') {
            when {
                anyOf {
                    branch 'main'
                    branch 'master'
                }
            }
            steps {
                sh '''
                echo "Pushing image to PROD repository..."
                docker tag ${DOCKER_USER}/react-app:${IMAGE_TAG} ${DOCKER_USER}/${PROD_REPO}:${IMAGE_TAG}
                docker tag ${DOCKER_USER}/react-app:${IMAGE_TAG} ${DOCKER_USER}/${PROD_REPO}:latest
                docker push ${DOCKER_USER}/${PROD_REPO}:${IMAGE_TAG}
                docker push ${DOCKER_USER}/${PROD_REPO}:latest
                '''
            }
        }

        stage('Deploy to EC2') {
            steps {
                sh '''
                echo "Deploying application..."
                docker compose down || true
                docker compose up -d
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully"
        }
        failure {
            echo "❌ Pipeline failed"
        }
        always {
            sh 'docker system prune -f'
        }
    }
}
