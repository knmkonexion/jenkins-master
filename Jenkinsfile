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
    
    // stage('Test Image') {
    //   agent {
    //     docker {
    //       label 'master'
    //       image "${IMAGE_NAME}:${IMAGE_VERSION}"
    //       alwaysPull true
    //       reuseNode true
    //     }
    //   }
    //   steps {
    //     sh """
    //       docker version
    //       kubectl version
    //     """
    //   }
    // }

  }
}