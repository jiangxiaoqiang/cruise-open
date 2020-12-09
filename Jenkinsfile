pipeline{
    agent any

    stages{
        stage('GIT PULL') {
            steps {
                git branch: "develop",
                url: 'https://github.com/jiangxiaoqiang/Cruise.git',
                credentialsId: 55c57ee9-4295-415d-9235-5d5a56bacf37
            }
        }

        stage('BUILD') {
            steps {
                sh '''
                  #!/bin/sh
                  flutter build apk --debug
                  '''
            }
        }

        stage('DISTRIBUTE') {
            steps {
                appCenter apiToken: 'f51cd29ba6b2d34a84cd99bc37348db77624c614',
                        ownerName: 'ranaranvijaysingh9-gmail.com',
                        appName: 'Flutter-Starter',
                        pathToApp: 'build/app/outputs/apk/debug/app-debug.apk',
                        distributionGroups: 'AlphaTester'
            }
        }
    }
}









