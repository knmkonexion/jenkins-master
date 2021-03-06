pipeline {

  agent { label 'master' }

  environment {
    registry = 'knmkonexion'
    registryCredential = 'kasey-dockerhub'
    dockerImage = ''
    IMAGE_NAME = 'jenkins'
    IMAGE_VERSION = 'latest'
  }

  stages {

    stage('Build Image') {
      steps {
        script {
          dockerImage = docker.build "${registry}/${IMAGE_NAME}:${IMAGE_VERSION}"
        }
      }
    }
    
    stage('Test Image') {
      agent {
        docker {
          label 'master'
          image "${registry}/${IMAGE_NAME}:${IMAGE_VERSION}"
          registryCredentialsId "${registryCredential}"
          reuseNode true
        }
      }
      steps {
        sh """
          docker version
          kubectl help
        """
      }
    }

    stage('Publish Image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) { dockerImage.push() }
        }
      }
    }
 
  }
}