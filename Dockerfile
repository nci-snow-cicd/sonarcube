FROM nrizk83/ubuntu-base-image:8

# update
RUN apt-get -y update

# install java7
RUN apt-get install -y unzip
RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
# install sonarqube
RUN wget -O /tmp/sonarqube-5.1.1.zip http://downloads.sonarsource.com/sonarqube/sonarqube-5.1.1.zip
RUN unzip /tmp/sonarqube-5.1.1.zip -d /opt/
ENV SONAR_HOME /opt/sonarqube-5.1.1

# configuration
# example with postgres :
# RUN sed -i -e 's/#sonar.jdbc.username=sonar/sonar.jdbc.username=sonar/' ${SONAR_HOME}/conf/sonar.properties
# RUN sed -i -e 's/#sonar.jdbc.password=sonar/sonar.jdbc.password=sonar/' ${SONAR_HOME}/conf/sonar.properties
# RUN sed -i -e 's/#sonar.jdbc.url=jdbc:postgresql:\/\/localhost\/sonar/sonar.jdbc.url=jdbc:postgresql:\/\/localhost\/sonar/' ${SONAR_HOME}/conf/sonar.properties

# example by replacing the file sonar.properties :
# ADD sonar.properties ${SONAR_HOME}/conf/sonar.properties

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# expose ports
EXPOSE 9000

# script to start the container

ADD sonarcube_run.sh /sonarcube_run.sh
RUN chmod 755 /*.sh
CMD ["/sonarcube_run.sh"]
