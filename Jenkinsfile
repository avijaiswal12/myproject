pipeline {
    agent any
    parameters {
        string(name: 'PROJECT_NAME', defaultValue: 'MyProject', description: 'Name of the project')
        choice(name: 'ENVIRONMENT', choices: ['Development', 'Staging', 'Production'], description: 'Select the environment')
        booleanParam(name: 'ENABLE_FEATURE_X', defaultValue: true, description: 'Enable Feature X')
    }

    stages {
        stage('Building Pipeline') {
            when {
                expression { params.choice('ENVIRONMENT') == 'Staging' }
            }
            steps {
                echo 'Building the pipeline...'
                // Add your pipeline setup commands here
                sh 'docker --version'
            }
        }

        stage('Final Stage') 
        input {
            message 'Proceed to the final stage?'
            ok 'Yes, continue'
        }
            steps {
                sh 'echo "Building the project..."'
                // Add your build commands here
                sh 'java --version'
            }
        }
    }
}
