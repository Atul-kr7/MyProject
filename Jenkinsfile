pipeline {
    agent any

    tools {
        nodejs 'nodejs' // The name of the NodeJS installation
    }

    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials')
        GITHUB_CREDENTIALS = credentials('github-credentials')
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/your-repo/your-angular-project.git', credentialsId: 'github-credentials'
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
                    docker.build("your-dockerhub-username/your-image-name:${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image("your-dockerhub-username/your-image-name:${env.BUILD_ID}").push()
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
