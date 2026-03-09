pipeline {
  agent any
  parameters {
    string(name: 'GIT_REPO_URL', description: 'Enter Github Repo', defaultValue: "https://github.com/ardhendusgit/java-web-app-ci.git")
  }
  environment {
    DOCKER_IMAGE = "ardhendushekhar/java-app:v2"
    DOCKER_CREDS = credentials('docker-pat')
  }
  stages{
    stage("Checkout"){
        steps{
            git url: "${params.GIT_REPO_URL}", branch: "main"
        }
    }

    stage("Build Artifact"){
      steps{
        sh 'mvn clean package -DskipTests'
      }
    }
    stage("Build Docker Image"){
      steps{
        sh 'docker build -t $DOCKER_IMAGE .'
      }
    }
    stage("Push Docker Image"){
      steps{
        sh '''
          echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin
          docker push $DOCKER_IMAGE
        '''
      } 
    }
  }
}
