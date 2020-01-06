# Version: 0.1
FROM centos:7
MAINTAINER Pyshen "pyshen@example.com"

# yum change to 163 and update
RUN curl -O http://mirrors.163.com/.help/CentOS7-Base-163.repo
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak && mv ./CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum -y clean all && yum -y makecache && yum -y install epel-* && yum -y update 

# install lib devel
RUN yum install -y python-devel mysql-devel openldap-devel gcc python-pip openssl-devel python-devel libffi-devel


# create app web
RUN mkdir -p /opt/webapp/ && mkdir -p ~/.pip/
ADD srcpm/requirement.txt /opt/webapp/requirement.txt

# create pip conf
ADD srcpm/pip.conf ~/.pip/pip.conf

# install python lib env
WORKDIR /opt/webapp/
RUN pip install requests==2.5.3 && pip install -r requirement.txt

# modify lib env
COPY srcpm/venv_srcpm/lib/python2.7/site-packages/flask_bootstrap/__init__.py /lib/python2.7/site-packages/flask_bootstrap/__init__.py
COPY srcpm/venv_srcpm/lib/python2.7/site-packages/werkzeug/datastructures.py /lib/python2.7/site-packages/werkzeug/datastructures.py

# 代码放到容器里
COPY mkdir /opt/webapp/srcpm && srcpm /opt/webapp/srcpm

# open port
EXPOSE 5000