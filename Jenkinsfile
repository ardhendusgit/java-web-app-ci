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
        sh 'echo $USER'
        sh 'docker run hello-world'
      } 
    }
  }
}
