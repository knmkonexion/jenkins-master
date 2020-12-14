pipeline {

  agent { label 'master' }

  environment {
    IMAGE_NAME='jenkins'
    IMAGE_VERSION='local'
  }

  stages {

    stage('Build Image') {
      steps {
        sh """
          docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} .
        """
      }
    }
    
    stage('Test Image') {
      steps {
        sh """
          docker images
          docker rin -it ${IMAGE_NAME}:${IMAGE_VERSION} bash -c 'docker version'
          docker rin -it ${IMAGE_NAME}:${IMAGE_VERSION} bash -c 'kind version'
          docker rin -it ${IMAGE_NAME}:${IMAGE_VERSION} bash -c 'kubectl version'
        """
      }
    }

  }
}