ARG base_image=ruby:2.7.6
FROM ${base_image}
RUN apt-get update -qq && apt-get upgrade -y && apt-get install -y build-essential \
  libpq-dev libxml2-dev libxslt1-dev dumb-init default-jre

ENV APP_HOME /smokey
RUN mkdir $APP_HOME

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE 1

# Install Chromium and ChromiumDriver
RUN apt-get update -qq && apt-get install -y chromium chromium-driver && apt-get clean

WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
ADD .ruby-version $APP_HOME/
RUN bundle install

ADD . $APP_HOME

# Allow root user to run Chromium in Docker
ENV NO_SANDBOX 1

# Remove Cucumber advert
ENV CUCUMBER_PUBLISH_QUIET true

STOPSIGNAL SIGINT

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Users of the image are expected to override the default CMD and set env vars
# ENVIRONMENT, AUTH_USERNAME, AUTH_PASSWORD, and a profile flag.

CMD ["bundle", "exec", "cucumber", "--strict-undefined"]
