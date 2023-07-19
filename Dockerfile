ARG base_image=ghcr.io/alphagov/govuk-ruby-base:3.2.0
ARG builder_image=ghcr.io/alphagov/govuk-ruby-builder:3.2.0

ARG google_package_keyring=/usr/share/keyrings/google-linux-signing.gpg


FROM $builder_image AS builder

WORKDIR /tmp
ARG google_package_keyring
ADD https://dl-ssl.google.com/linux/linux_signing_key.pub google.pub
RUN gpg --dearmor < google.pub > "${google_package_keyring}"

WORKDIR $APP_HOME
COPY Gemfile* .ruby-version ./
RUN bundle install
COPY . ./


FROM $base_image
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Remove Cucumber advert.
ENV CUCUMBER_PUBLISH_QUIET=true
# Use the default glibc malloc.
ENV LD_PRELOAD=""

# Install Google Chrome and the corresponding version of ChromeDriver.
ARG google_package_keyring
ARG chromedriver_url=https://chromedriver.storage.googleapis.com/
COPY --from=builder $google_package_keyring $google_package_keyring
RUN arch=$(dpkg --print-architecture) && \
    echo "deb [arch=${arch} signed-by=${google_package_keyring}] https://dl.google.com/linux/chrome/deb/ stable main" \
        > /etc/apt/sources.list.d/google.list
RUN install_packages dumb-init google-chrome-stable=114.0.5735.198-1 unzip
# TODO: support arm64 when available (perhaps by just switching back to ChromiumDriver?).
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
CMD ["cucumber", "--strict-undefined"]
