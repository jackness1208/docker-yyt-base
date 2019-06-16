FROM ubuntu:18.04
LABEL authors="liudaojie <liudaojie@yy.com>"

# apt 加速
RUN  echo "deb http://archive.ubuntu.com/ubuntu bionic main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu bionic-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu bionic-security main universe\n" >> /etc/apt/sources.list

WORKDIR /root

# apt 基础组件安装
RUN apt-get update
RUN apt-get -qqy upgrade
RUN apt-get -qqy install apt-utils

# 时区包安装
ENV DEBIAN_FRONTEND=noninteractive
ENV TIME_ZONE Asiz/Shanghai
RUN apt-get install -qqy tzdata

# 基础库安装
RUN apt-get -y --no-install-recommends install \
  software-properties-common \
  ca-certificates \
  sudo \
  curl \
  yarn \
  wget \
  vim \
  git \
  zip \
  unzip \
  xz-utils \
  bzip2 \
  apt-transport-https \
  jq \
  libxml-xpath-perl \
  xfonts-100dpi \
  xfonts-75dpi \
  xfonts-scalable \
  xfonts-cyrillic \
  xvfb \
  x11-apps \ 
  libqt5webkit5 \
  libgconf-2-4 \
  gnupg \
  salt-minion \
  imagemagick

# vim 安装
RUN apt-get install vim -y

# vimrc 配置
RUN git clone https://github.com/jackness1208/vimrc.git
RUN cp -rf /root/vimrc/centos/vimrc /etc/vimrc
RUN rm -rf /root/vimrc

# 安装 jdk
RUN apt-get install openjdk-8-jdk -y

# 设置 JAVA_HOME
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre" \
  PATH=$PATH:$JAVA_HOME/bin

# 安装 node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get -y install nodejs

RUN npm i npm@latest -g \
  && npm config set user 0 \
  && npm config set unsafe-perm true

# 安装 chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update -yq
RUN apt-get -yqq install google-chrome-stable

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && sudo dpkg -i google-chrome*.deb \
  && apt-get install -f -y

RUN rm -rf google-chrome-stable_current_amd64.deb

# 清除安装包
RUN rm -rf /var/lib/apt/lists/*

# 运行 xvfb
# CMD Xvfb -ac :7 -screen 0 1920x1080x8