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
                withCredentials([usernamePassword(credentialsId: '77fca4f9-3889-4968-80d3-0c2f902883dd', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                    sh '''
                        git config --global user.email "avijaiswal123@example.com"
                        git config --global user.name "Avinash Jaiswal"
                        git remote set-url origin https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/avijaiswal12/myproject.git
                        mvn build-helper:parse-version versions:set \
                          -DnewVersion=\\${parsedVersion.majorVersion}.\\${parsedVersion.minorVersion}.\\${parsedVersion.nextIncrementalVersion} \
                          versions:commit
                        #git add pom.xml
                       #git commit -m "Bump version [ci skip]" || echo "No changes to commit"
                        #git push origin HEAD
                    '''
                }
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

        stage('Building Image') {
            steps {
                input message: 'Proceed to the final stage?', ok: 'Yes, continue'
                echo "Deploying to ${params.ENVIRONMENT} environment"
                echo "Building the DockerImage ${params.PROJECT_NAME}"
                // Add your build commands here
                script {
                    def envLower = params.ENVIRONMENT.toLowerCase()
                    sh "docker build -t samplewebapp-${envLower} ."
                    sh "docker run -d --name samplewebapp -p 8082:8080 samplewebapp-${envLower}"
                }
                            
            }
        }
    }
    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}
