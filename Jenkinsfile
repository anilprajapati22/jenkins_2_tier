def awsCredentials = [[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws']]
pipeline {
  agent  { label 'agent-test'}
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
        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 590852515231.dkr.ecr.us-east-1.amazonaws.com"
        sh "docker build -t anilp-sgn-repo-docker ."
        sh "docker tag anilp-sgn-repo-docker:latest 590852515231.dkr.ecr.us-east-1.amazonaws.com/anilp-sgn-repo-docker:build-${currentBuild.number}"
        sh "docker push 590852515231.dkr.ecr.us-east-1.amazonaws.com/anilp-sgn-repo-docker:build-${currentBuild.number}"
        }
        }
    }
  }
}