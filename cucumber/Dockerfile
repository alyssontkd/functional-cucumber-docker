FROM ruby:2.6-stretch

MAINTAINER Alysson Vicuña <alysson.vicuna@gmail.com>
ARG TIME_ZONE="America/Sao_Paulo"
# Set the timezone.
RUN echo ${TIME_ZONE} > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata


RUN /bin/bash -c "ruby --version"
############################
RUN apt-get update -qq && apt-get install -y ruby-capybara ruby-capybara-screenshot vim

###########################
# install dependencieis
#RUN apt-get update -qq && apt-get install -y build-essential libpq-dev openjdk-8-jre-headless lib32z1 lib32ncurses5 g++-multilib libxi6 libgconf-2-4 xvfb default-jdk 
#RUN apt-get install -y unzip curl git vim wget
#RUN apt-get upgrade -y
#RUN apt-get install -y patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

#RUN npm install -g phantomjs-prebuilt --unsafe-perm --upgrade --silent

# Set up the Chrome PPA
#RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
#RUN echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

# Copiando os arquivos customizados para a automação
COPY ./src/sources.list /etc/apt/
COPY ./src/config.yml /tmp
COPY ./src/cucumber.yaml /tmp
COPY ./src/env.rb /tmp

# Update the package list and install chrome
#RUN apt-get update -qq && apt-get install -y google-chrome-stable ttf-mscorefonts-installer

# ChromeDriver 72.0.3626.122
RUN apt-get update -qq && apt-get install -y chromedriver

COPY ./src/poupex.com.br.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

WORKDIR /usr/src/app/cucumber-petshop
RUN /bin/bash -c "ruby --version && gem update --system && gem install bundler && gem update"

COPY docker-entrypoint.sh /usr/local/bin/
#ENTRYPOINT ["/bin/bash" , "-c", "source /etc/profile.d/rvm.sh && rvm reload && docker-entrypoint.sh && tail -f /dev/null"]
ENTRYPOINT ["/bin/bash" , "-c", "docker-entrypoint.sh && tail -f /dev/null"]
