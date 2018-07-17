FROM circleci/android:api-23-alpha

ARG NODE_VERSION=10.6.0
RUN mkdir -p /tmp && cd /tmp
RUN curl -LO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz"
RUN tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 --no-same-owner
RUN rm "node-v$NODE_VERSION-linux-x64.tar.xz"
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs

# Install Cordova and Ionic
RUN sudo npm install -g ionic cordova@8.0.0 && cordova telemetry off && CI=true ionic config set -g daemon.updates false && ionic config set -g telemetry false

# Install Gradle
ARG GRADLE_VERSION=4.5.1
RUN sudo curl https://downloads.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip > /tmp/gradle-$GRADLE_VERSION-bin.zip && sudo unzip /tmp/gradle-$GRADLE_VERSION-bin.zip -d /tmp && rm /tmp/gradle-$GRADLE_VERSION-bin.zip && sudo mv /tmp/gradle-$GRADLE_VERSION /opt/gradle
