pipeline {
    agent any
    environment { 
        sgnenv = "Hello this is the value of env variable"
        // DOCKERHUB_CREDENTIALS=credentials('dockerhub')
    }

    stages {
            stage('Code-Fetch') {
            steps {
                echo "code fetching from git"
                git 'https://github.com/anilprajapati22/jenkins_2_tier.git'
            }
        }
        // stage('Login') {

		// 	steps {
		// 		sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
		// 	}
		// }
        
        stage('Build-Mysql') {
            agent { label 'agent-test' }
            steps {
                echo "Mysql"
                sh "docker rm -f my-mysql || true"
                sh 'docker run -d --name my-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_PASSWORD=passwd -e MYSQL_USER=sgn -e MYSQL_DATABASE=sgndb mysql:8'
            }
        }
        
        stage('Build-php-server') {
            
            steps {
                echo "creating php server"
                sh 'docker build -t php-server .'
            }
        }
        stage('Deploy-php-server') {
            steps {
                sh 'docker rm -f php-server || true'
                sh 'docker run -d -p 80:80 --name php-server php-server'
                sh 'docker logs php-server'
            }
        }


        // stage('cleanup') {
        //     steps {
        //         echo "Clear docker container"
        //         sh 'docker rm -f flask-server'
        //     }
        // }        
    }
}
