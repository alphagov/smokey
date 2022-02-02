FROM ruby:2.7.5
FROM ${base_image}
RUN apt-get update -qq && apt-get upgrade -y && apt-get install -y build-essential \
  libpq-dev libxml2-dev libxslt1-dev dumb-init default-jre

ENV APP_HOME /smokey
RUN mkdir $APP_HOME

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE 1

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -y google-chrome-stable && apt-get clean

WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
ADD .ruby-version $APP_HOME/
RUN bundle install
ADD Rakefile $APP_HOME
RUN bundle exec rake webdrivers:chromedriver:update

ADD . $APP_HOME

# Allow root user to run Chrome in Docker
ENV NO_SANDBOX 1

# Remove Cucumber advert
ENV CUCUMBER_PUBLISH_QUIET true

STOPSIGNAL SIGINT

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Users of the image are expected to override the default CMD and set env vars
# ENVIRONMENT, AUTH_USERNAME, AUTH_PASSWORD, and a profile flag.

CMD ["bundle", "exec", "cucumber", "--strict-undefined", "-t 'not @benchmarking'"]
