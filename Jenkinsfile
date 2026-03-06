pipeline {
  agent any
  parameters {
    string(name: 'GIT_REPO_URL', description: 'Enter Github Repo', defaultValue: "https://github.com/ardhendusgit/java-web-app-ci.git")
  }
  stages{
    stage("Checkout"){
        steps{
            git url: "${params.GIT_REPO_URL}", branch: "main"
        }
    }
    stage("Docker test"){
      steps{
        sh 'id'
        sh 'id -u'
        sh 'ls -l /var/run/docker.sock'
        sh 'docker version'
      } 
    }
  }
}
