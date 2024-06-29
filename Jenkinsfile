pipeline {
    agent any

    tools {
        nodejs 'nodejs' // Adjust based on your NodeJS installation name
    }

    environment {
        DOCKER_CREDENTIALS = credentials('docker-credentials-id') // Use correct ID
        GITHUB_CREDENTIALS = credentials('github-pat-id') // Use correct ID
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Atul-kr7/MyProject.git', branch: 'master', credentialsId: 'github-pat-id'
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
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-credentials-id') {
                        docker.image("atulkr7/myproject:${env.BUILD_ID}").push()
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'kube-config-id', serverUrl: 'https://your-kubernetes-cluster']) {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
