pipeline{
  agent any
  environment{
    IMAGE_NAME = 'chandru1033'
  }
  stages {
    stage('chechout'){
      steps{
        echo 'getting source code'
        checkout scm
      }
    }
    stage('Docker version'){
      steps{
        sh 'docker --version'
      }
    }
    stage('build the docker image')
    {
      steps{
        sh 'docker build -t "$IMAGE_NAME:1" .'
      }
    }
    stage('Docker Login'){
      steps{
        withCredentials([
          usernamepassword(
            credentialsId: 'dockerhub-creds',
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PASS',
            )
          ]){
          sh '''
          set +X
          echo "$DOCKER_PASS" | docker login \
          --username "DOCKER_USER" \
          --password-stdin
          '''
        }
      }
    }
    stage('push the image to the Docker'){
      steps{
        sh '''
           docker push "$IMAGE_NAME:$1"
           '''
      }
    }
  }
  post{
    success{
      echo 'docker image successfully published'
    }
    failure{
      echo 'pipeline failed'
    }
    always{
      sh 'docker logout || true'
    }
  }
}

            
