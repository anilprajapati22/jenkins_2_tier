def awsCredentials = [[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws']]
pipeline {
  agent any
  stages {
    stage('build no'){
        when{
            branch "dev*"
        }
        steps {
        withCredentials([gitUsernamePassword(credentialsId: 'sgnons_id', gitToolName: 'git-tool')]) {
        sh 'git fetch --all'
        sh """
        git tag build-${currentBuild.number}
        git push origin build-${currentBuild.number}
        """
        }
        withCredentials(awsCredentials){
        sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/s5o7d0z2"
        sh "docker build -t adarsh-repo ."
        sh "docker tag anil-php-server:latest public.ecr.aws/s5o7d0z2/anil-php-server:build-${currentBuild.number}"
        sh "docker push public.ecr.aws/s5o7d0z2/anil-php-server:build-${currentBuild.number}"
        }
        }
    }
  }
}