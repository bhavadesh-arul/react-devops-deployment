pipeline {
    agent any

    environment {
        DOCKERHUB_USER = "bhavadesh"
        DEV_IMAGE  = "bhavadesh/react-devops-dev"
        PROD_IMAGE = "bhavadesh/react-devops-prod"
        APP_NAME   = "react-app"
    }

    stages {

        stage("Checkout Code") {
            steps {
                checkout scm
            }
        }

        stage("Build Docker Image") {
            steps {
                echo "Building Docker image..."
                sh '''
                  chmod +x build.sh
                  ./build.sh
                '''
            }
        }

        stage("Docker Login") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage("Push Image to Docker Hub") {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        echo "Pushing DEV image..."
                        sh """
                          docker tag react-app-test ${DEV_IMAGE}:latest
                          docker push ${DEV_IMAGE}:latest
                        """
                    }

                    if (env.BRANCH_NAME == 'master') {
                        echo "Pushing PROD image..."
                        sh """
                          docker tag react-app-test ${PROD_IMAGE}:latest
                          docker push ${PROD_IMAGE}:latest
                        """
                    }
                }
            }
        }

        stage("Deploy Application") {
            steps {
                echo "Deploying application..."
                sh '''
                  chmod +x deploy.sh
                  ./deploy.sh
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}
