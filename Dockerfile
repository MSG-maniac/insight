# Version: 0.1
FROM python:2.7.17-alpine3.9
MAINTAINER Pyshen "pyshen@example.com"

# create app web
RUN mkdir -p /opt/webapp/ && mkdir -p ~/.pip/
ADD srcpm/requirement.txt /opt/webapp/requirement.txt

RUN apk add build-base openldap-dev python2-dev mysql-dev py-mysqldb

# install python lib env
WORKDIR /opt/webapp/
RUN pip install -r requirement.txt && \
rm -rf /root/.cache/pip && \
mkdir /opt/webapp/srcpm

# 代码放到容器里
COPY srcpm /opt/webapp/srcpm

ADD srcpm/entrypoint.sh /entrypoint.sh
# open port
EXPOSE 5000

CMD /bin/sh /entrypoint.sh