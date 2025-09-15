# -----------------------------
# Base image: JDK 21
# -----------------------------
FROM eclipse-temurin:21-jdk

LABEL maintainer="SolDevelo <aws-support@soldevelo.com>"
LABEL description="Atlassian Plugin SDK with Node.js 20, based on JDK 21"

# -----------------------------
# Environmental variables
# -----------------------------
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

ENV ATLASSIAN_PLUGIN_SDK_VERSION=8.2.8
ENV ATLAS_HOME=/usr/share/atlassian-plugin-sdk-$ATLASSIAN_PLUGIN_SDK_VERSION/
ENV PATH=$ATLAS_HOME/bin:$PATH

ENV MAVEN_VERSION=3.9.6
ENV PATH=/opt/apache-maven/bin:$PATH

ENV NODE_VERSION=20.8.1

# -----------------------------
# Install system tools
# -----------------------------
RUN apt-get update && apt-get install -y \
    curl unzip git wget zip xz-utils && \
    rm -rf /var/lib/apt/lists/*

# -----------------------------
# Install Node.js
# -----------------------------
RUN curl -fsSL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz -o /tmp/node.tar.xz && \
    tar -xJf /tmp/node.tar.xz -C /usr/local --strip-components=1 && \
    rm /tmp/node.tar.xz && \
    node -v && npm -v

# -----------------------------
# Install Atlassian Plugin SDK (locally)
# -----------------------------
COPY atlassian-plugin-sdk-$ATLASSIAN_PLUGIN_SDK_VERSION.tar.gz /tmp/
RUN tar -xzf /tmp/atlassian-plugin-sdk-$ATLASSIAN_PLUGIN_SDK_VERSION.tar.gz -C /usr/share/ && \
    rm /tmp/atlassian-plugin-sdk-$ATLASSIAN_PLUGIN_SDK_VERSION.tar.gz

# -----------------------------
# Install Maven
# -----------------------------
RUN wget https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -O /tmp/maven.tar.gz && \
    tar -xzf /tmp/maven.tar.gz -C /opt/ && \
    rm /tmp/maven.tar.gz && \
    ln -s /opt/apache-maven-$MAVEN_VERSION /opt/apache-maven

# -----------------------------
# Working directory and default command
# -----------------------------
WORKDIR /usr/src/app
CMD ["atlas-version"]
