pipeline {
    agent any

    tools {
        jdk 'JAVA_HOME'
        maven 'M2_HOME'
    }

    stages {
        stage('Checkout') {
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

        stage('Build Maven') {
            steps {
                sh 'mvn compile'
            }
        }
    }
}
