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
                expression { params.ENVIRONMENT == 'Staging' }
            }
            steps {
                echo 'Building the pipeline...'
                // Add your pipeline setup commands here
                sh 'docker --version'
            }
        }

        stage('Final Stage') {
            steps {
                input message: 'Proceed to the final stage?', ok: 'Yes, continue'
                echo "Deploying to ${params.ENVIRONMENT} environment"
                echo "Building the project ${params.PROJECT_NAME}"
                // Add your build commands here
                sh 'java --version'
                mvn build-helper:parse-version versions:set \
                      -DnewVersion=\\${parsedVersion.majorVersion}.\\${parsedVersion.minorVersion}.\\${parsedVersion.nextIncrementalVersion} \
                      versions:commit
                git add pom.xml
                git commit -m "Bump version [ci skip]" || echo "No changes to commit"
                git push origin HEAD
            }
        }
    }
    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}
