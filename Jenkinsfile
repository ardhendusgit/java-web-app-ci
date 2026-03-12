pipeline {
  agent any
  tools{
      maven 'MAVEN3'
      jdk 'JDK21'
  }
  parameters {
    string(name: 'GIT_REPO_URL', description: 'Enter Github Repo', defaultValue: "https://github.com/ardhendusgit/java-web-app-ci.git")
  }
  environment {
    DOCKER_IMAGE_NAME = "ardhendushekhar/java-app"
    DOCKER_CREDS = credentials('docker-pat')
    GITOPS_FOLDER_PATH = "yaml"
    DOCKER_IMAGE_TAG = ${BUILD_NUMBER}
  }
  stages{
    stage("Checkout"){
        steps{
            git url: "${params.GIT_REPO_URL}", branch: "main", credentialsId: 'git-ssh'
        }
    }

    stage("Build Artifact"){
      steps{
        sh 'mvn clean package -DskipTests'
      }
    }
    stage("Build Docker Image"){
      steps{
        sh 'docker build -t $DOCKER_IMAGE_NAME:v$DOCKER_IMAGE_TAG .'
      }
    }
    stage("Push Docker Image"){
      steps{
        sh '''
          echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin
          docker push $DOCKER_IMAGE_NAME:v$DOCKER_IMAGE_TAG
        '''
      } 
    }
    stage('Update GitOps YAML') {
        steps {
        sshagent(credentials: ['git-ssh']) {
            sh '''
                cd ${GITOPS_FOLDER_PATH}
                sed -i "s|image: .*|image: ${DOCKER_IMAGE}|" deployment.yaml
                git config user.name "jenkins"
                git config user.email "jenkins@ci"
                git commit -am "Update image to ${DOCKER_IMAGE}" || echo "No changes to commit"
                git push origin main
            '''
          }
        }
      }
  }
}
