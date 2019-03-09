FROM ubuntu:bionic-20181204
LABEL authors="liudaojie <liudaojie@yy.com>"

# apt 加速
RUN  echo "deb http://archive.ubuntu.com/ubuntu bionic main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu bionic-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu bionic-security main universe\n" >> /etc/apt/sources.list


# apt 基础组件安装
RUN apt-get update
RUN apt-get -y install \
  software-properties-common \
  ca-certificates \
  sudo \
  curl \
  yarn \
  wget \
  vim \
  git


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
RUN sudo apt-get -y install \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatspi2.0-0 \
  libgtk-3-0 \
  libx11-xcb1 \
  xdg-utils \
  libxss1 \
  libappindicator1 \
  libindicator7

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && sudo dpkg -i google-chrome*.deb \
  && apt-get install -f -y
