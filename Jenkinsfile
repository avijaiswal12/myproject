pipeline {
    agent any
    parameters {
        string(name: 'PROJECT_NAME', defaultValue: 'MyProject', description: 'Name of the project')
        choice(name: 'ENVIRONMENT', choices: ['Development', 'Staging', 'Production'], description: 'Select the environment')
        booleanParam(name: 'ENABLE_FEATURE_X', defaultValue: true, description: 'Enable Feature X')
    }

    stages {
        stage('Intialize') {
            steps {
                echo 'Updating the New POM version...'
                sh '''
                    mvn build-helper:parse-version versions:set \
                      -DnewVersion=\\${parsedVersion.majorVersion}.\\${parsedVersion.minorVersion}.\\${parsedVersion.nextIncrementalVersion} \
                      versions:commit
                git add pom.xml
                git commit -m "Bump version [ci skip]" || echo "No changes to commit"
                git push origin HEAD                
                '''
            }
        }
        
        stage('Building Pipeline') {
            when {
                expression { params.ENVIRONMENT == 'Staging' }
            }
            steps {
                echo 'Building the pipeline...'
                // Add your pipeline setup commands here
                sh 'mvn clean package'
            }
        }

        stage('Final Stage') {
            steps {
                input message: 'Proceed to the final stage?', ok: 'Yes, continue'
                echo "Deploying to ${params.ENVIRONMENT} environment"
                echo "Building the DockerImage ${params.PROJECT_NAME}"
                // Add your build commands here
                sh "docker build -t samplewebapp-${params.ENVIRONMENT} ."
                sh 'sh 'docker run -d --name samplewebapp -p 8082:8080 samplewebapp'
                            
            }
        }
    }
    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}
