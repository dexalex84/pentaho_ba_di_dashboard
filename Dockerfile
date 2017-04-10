FROM centos:latest
RUN rpm -Uvh https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
RUN yum update -y && yum install wget java-1.8.0-openjdk unzip -y && yum install postgresql96 -y

ENV PATH /usr/pgsql-9.6/bin:$PATH

RUN mkdir /opt/pentaho
WORKDIR /opt/pentaho


# Name of archive with Pentaho DI
ENV BA_ARCHIVE_NAME=pentaho-server-ce-7.0.0.0-25.zip

# Copy files in Distr folder from project root to container /tmp/distr
ADD ./distr/app_pentaho_ba/ /tmp/distr

RUN echo Copy or Download from Sourceforge.net

# If file exists in distr /tmp/distr/ (in container) copy it to /opt/pentaho
RUN if [  -f /tmp/distr/$BA_ARCHIVE_NAME ]; \
      then cp /tmp/distr/$BA_ARCHIVE_NAME /opt/pentaho; \
# otherwise get it from sourceforge and copy to the same place
    else wget -O $BA_ARCHIVE_NAME \
     https://sourceforge.net/projects/pentaho/files/Business%20Intelligence%20Server/7.0/$BA_ARCHIVE_NAME/download --progress=bar:force ; \
      cp /tmp/distr/$BA_ARCHIVE_NAME /opt/pentaho; \
    fi

#RUN echo "Unzip downloded file"
RUN unzip -q $BA_ARCHIVE_NAME 
RUN rm  $BA_ARCHIVE_NAME  -f

WORKDIR /opt/pentaho/pentaho-server
