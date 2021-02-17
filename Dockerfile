FROM python:3.6-stretch

# Install Java for Spark and Hadoop
RUN apt-get update -y && apt-get install -y openjdk-8-jdk zip zipmerge
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Download Spark
ARG SPARK_VERSION=2.4.5
ARG SPARK_HADOOP_VERSION=2.7
ENV SPARK_HOME /opt/spark
RUN wget -qO - http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz | \
  tar -xz -C /opt/ && \
  mv /opt/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION} ${SPARK_HOME}

# Download Hadoop for hdfs cli
ARG HADOOP_VERSION=3.1.4
ENV HADOOP_HOME /opt/hadoop
RUN wget -qO - http://apache.mirror.digionline.de/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | \
  tar -xz -C /opt/ && \
  mv /opt/hadoop-${HADOOP_VERSION} ${HADOOP_HOME}

# Set up PATH to include spark and hadoop
ENV PATH ${PATH}:${SPARK_HOME}/bin:${SPARK_HOME}/sbin:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:${PATH}
