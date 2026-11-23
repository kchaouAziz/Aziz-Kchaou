pipeline {
    agent any

    tools {
        jdk 'JAVA_HOME'
        maven 'M2_HOME'
    }

    environment {
        DOCKER_USER = "azizkchaou"
        BACKEND_IMAGE = "${DOCKER_USER}/aziz-kchaou-backend"
        SQL_IMAGE = "${DOCKER_USER}/aziz-kchaou-mysql"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Stage 1: Checkout') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        credentialsId: 'git-credentials-id',
                        url: 'https://github.com/kchaouAziz/Aziz-Kchaou.git'
                    ]]
                )
            }
        }

        stage('Stage 2: Build Maven') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Stage 3: Package') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }

        stage('Stage 4: Docker Build') {
            steps {
                sh """
                    docker build -t ${BACKEND_IMAGE}:${IMAGE_TAG} -t ${BACKEND_IMAGE}:latest -f Dockerfile .
                    docker build -t ${SQL_IMAGE}:${IMAGE_TAG} -t ${SQL_IMAGE}:latest -f Dockerfile.sql .
                """
            }
        }

        stage('Stage 5: Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh """
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push ${BACKEND_IMAGE}:${IMAGE_TAG}
                        docker push ${BACKEND_IMAGE}:latest
                        docker push ${SQL_IMAGE}:${IMAGE_TAG}
                        docker push ${SQL_IMAGE}:latest
                        docker logout
                    """
                }
            }
        }
    }
}
