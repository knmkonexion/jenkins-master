FROM jenkins/jenkins:lts

USER root

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Install Docker CLI and dependencies
RUN apt update && apt install -y lsb-release \
    software-properties-common \
    apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt update && apt install -y docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.3/bin/linux/amd64/kubectl \
    && chmod a+x ./kubectl \
    && mv ./kubectl /usr/local/bin

USER jenkins

# Copy plugins.txt to the $REF/init.groovy.d directory, already set up in base jenkins image; install plugins
COPY plugins.txt ${REF}/init.groovy.d/plugins.txt
RUN install-plugins.sh < ${REF}/init.groovy.d/plugins.txt

# Copy Configuration as Code file to ${REF}
# ENV CASC_JENKINS_CONFIG ${REF}/casc.yaml
# COPY casc.yaml ${REF}/casc.yaml

WORKDIR $JENKINS_HOME