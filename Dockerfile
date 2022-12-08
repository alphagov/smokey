ARG base_image=ghcr.io/alphagov/govuk-ruby-base:3.1.2
ARG builder_image=ghcr.io/alphagov/govuk-ruby-builder:3.1.2

FROM $builder_image AS builder

WORKDIR $APP_HOME
COPY Gemfile* .ruby-version ./
RUN bundle install
COPY . ./


FROM $base_image
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Remove Cucumber advert.
ENV CUCUMBER_PUBLISH_QUIET=true

# Install Google Chrome and the corresponding version of ChromeDriver.
ARG chromedriver_url=https://chromedriver.storage.googleapis.com/
ADD https://dl-ssl.google.com/linux/linux_signing_key.pub /tmp/google.pub
RUN arch=$(dpkg --print-architecture) && \
    keyring=/usr/share/keyrings/google-linux-signing.gpg && \
    gpg --dearmor < /tmp/google.pub > "${keyring}" && \
    echo "deb [arch=${arch} signed-by=${keyring}] https://dl.google.com/linux/chrome/deb/ stable main" \
        > /etc/apt/sources.list.d/google.list && \
    install_packages dumb-init google-chrome-stable unzip && \
    rm -fr /tmp/*
RUN chrome_ver=$(google-chrome --version | grep -Po '\d+\.\d+\.\d+') && \
    chromedriver_ver=$(curl -LSfs "${chromedriver_url}LATEST_RELEASE_${chrome_ver}") && \
    curl -LSfs "${chromedriver_url}${chromedriver_ver}/chromedriver_linux64.zip" \
        | funzip >/usr/bin/chromedriver && \
    chmod 755 /usr/bin/chromedriver

WORKDIR $APP_HOME
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder $APP_HOME ./

STOPSIGNAL SIGINT
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
USER app
# Users are expected to override the default CMD and set the ENVIRONMENT env
# var and optionally PROFILE to specify a Cucumber profile.
CMD ["bundle", "exec", "cucumber", "--strict-undefined"]
