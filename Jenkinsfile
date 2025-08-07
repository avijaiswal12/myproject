pipeline {
    agent any

    stages {
        stage('Building Pipeline') {
            steps {
                echo 'Building the pipeline...'
                // Add your pipeline setup commands here
                sh 'docker --version'
            }
        }

        stage('Final Stage') {
            steps {
                sh 'echo "Building the project..."'
                // Add your build commands here
                sh 'java --version'
            }
        }
    }
}
