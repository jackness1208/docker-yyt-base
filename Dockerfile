FROM ubuntu:16.04
LABEL authors="liudaojie <liudaojie@yy.com>"

# apt 加速
RUN  echo "deb http://archive.ubuntu.com/ubuntu bionic main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu bionic-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu bionic-security main universe\n" >> /etc/apt/sources.list


# apt 基础组件安装
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install \
  software-properties-common \
  ca-certificates \
  sudo \
  curl \
  yarn \
  wget \
  vim \
  git \
  unzip \
  apt-utils \
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
  imagemagick

# 安装 jdk
RUN add-apt-repository ppa:webupd8team/java -y \
  && apt-get install openjdk-8-jre-headless -y

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

# ENV CHROMEDRIVER_FORCE_DOWNLOAD true
# ENV CHROMEDRIVER_FILEPATH /usr/local/bin/chromedriver
# RUN export DBUS_SESSION_BUS_ADDRESS=/dev/null

EXPOSE 9515
EXPOSE 7000
CMD Xvfb -ac :7 -screen 0 1280x1024x8