def awsCredentials = [[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws']]

pipeline {
    agent any
    environment { 
        sgnenv = "Hello this is the value of env variable"
        // DOCKERHUB_CREDENTIALS=credentials('dockerhub')
        AWS_CREDENTIALS = credentials('aws')
        
    }

    stages{
        stage('build'){
            steps{

                    withCredentials(awsCredentials){

                        sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/s5o7d0z2"
                        sh "docker build -t anil-php-server ."
                        sh "docker tag anil-php-server:latest public.ecr.aws/s5o7d0z2/anil-php-server:${currentBuild.number}"
                        sh "docker push public.ecr.aws/s5o7d0z2/anil-php-server:${currentBuild.number}"
                    }

                    withCredentials([gitUsernamePassword(credentialsId: 'sgnons_id', gitToolName: 'git-tool')]) {

                        sh """
                            git tag build-${currentBuild.number}
                            git push origin build-${currentBuild.number}
                            """


                    }   


            }
        }
    }

}

//  stages {
//             stage('Code-Fetch') {
//             steps {
//                 echo "code fetching from git"
//                 git 'https://github.com/anilprajapati22/jenkins_2_tier.git'
//             }
//         }
//         // stage('Login') {

// 		// 	steps {
// 		// 		sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
// 		// 	}
// 		// }
                
//         stage('Build-php-server') {
            
//             steps {
//                 echo "creating php server"
//                 sh 'docker build -t php-server .'
//             }
//         }
//         stage('Deploy-php-server') {

//             steps {
//                 sh 'docker rm -f php-server || true'
//                 sh 'docker run -d -p 81:80 --name php-server php-server'
//                 sh 'docker logs php-server'
//             }
//         }


//         // stage('cleanup') {
//         //     steps {
//         //         echo "Clear docker container"
//         //         sh 'docker rm -f flask-server'
//         //     }
//         // }        
//     }
// }
