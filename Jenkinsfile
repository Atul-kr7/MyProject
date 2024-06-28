pipeline {
    agent any

    tools {
        nodejs 'nodejs' // The name of the NodeJS installation
    }

    environment {
        DOCKER_CREDENTIALS = credentials('AT@95041ul')
        GITHUB_CREDENTIALS = credentials('github-pat')
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Atul-kr7/MyProject.git', credentialsId: 'github-pat'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Build') {
            steps {
                sh 'npm run build --prod'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("atulkr7/myproject:${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'AT@95041ul') {
                        docker.image("atulkr7/myproject:${env.BUILD_ID}").push()
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'kube-config', serverUrl: 'https://your-kubernetes-cluster']) {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
