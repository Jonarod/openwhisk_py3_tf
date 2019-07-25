# FROM openwhisk/python3action:latest

# FROM openwhisk/actionloop-python-v3.7:latest

# RUN python --version
# RUN pip --version

# RUN apk add --update py3-pip
# RUN pip install tensorflow==2.0.0-beta1


FROM ubuntu:latest

RUN apt-get update
# RUN apt-get install -y gcc
# RUN apt-get install -y libc-dev
# RUN apt-get install -y libxslt-dev
# RUN apt-get install -y libxml2-dev
# RUN apt-get install -y libffi-dev
# RUN apt-get install -y libssl-dev
# RUN apt-get install -y zip
# RUN apt-get install -y unzip
# # RUN apt-get install -y vim
RUN apt-get install -y python3.7
# RUN apt-get install -y python3.7-dev
# RUN apt-get install -y build-essential 
# RUN apt-get install -y libxslt1-dev
# RUN apt-get install -y zlib1g-dev
# RUN apt-get install -y libblas-dev libatlas-base-dev

RUN apt-get install -y curl

RUN apt-cache search linux-headers-generic

RUN cd ~/
RUN apt-get download python3-distutils
RUN dpkg-deb -x python3-distutils* /
RUN cd /
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.7
RUN rm -rf ~/python3-distutils*
RUN alias python=python3.7

RUN rm -rf /var/lib/apt/lists/*


ENV FLASK_PROXY_PORT 8080
ENV PYTHONIOENCODING "UTF-8"

# # rclone
# RUN curl -L https://downloads.rclone.org/rclone-current-linux-amd64.deb -o rclone.deb \
#     && dpkg -i rclone.deb \
#     && rm rclone.deb

# requirements
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip six && pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /actionProxy
# ADD https://raw.githubusercontent.com/apache/incubator-openwhisk-runtime-docker/dockerskeleton%401.3.3/core/actionProxy/actionproxy.py /actionProxy/actionproxy.py
COPY actionproxy.py /actionProxy/actionproxy.py

RUN mkdir -p /pythonAction
COPY pythonrunner.py /pythonAction/pythonrunner.py

CMD ["/bin/bash", "-c", "cd /pythonAction && python3.7 -u pythonrunner.py"]