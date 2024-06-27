ARG base_image=ghcr.io/alphagov/govuk-ruby-base:3.3
ARG builder_image=ghcr.io/alphagov/govuk-ruby-builder:3.3

FROM --platform=$TARGETPLATFORM $builder_image AS builder

WORKDIR $APP_HOME
COPY Gemfile* .ruby-version ./
RUN bundle install
COPY . ./

FROM --platform=$TARGETPLATFORM $base_image
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Remove Cucumber advert.
ENV CUCUMBER_PUBLISH_QUIET=true
# Use the default glibc malloc.
ENV LD_PRELOAD=""

COPY scripts/chromium.pref /etc/apt/preferences.d/chromium.pref
COPY scripts/debian-keys.asc /etc/apt/keyrings/debian-keys.asc

RUN arch=$(dpkg --print-architecture) && \
    echo "deb [arch=${arch} signed-by=/etc/apt/keyrings/debian-keys.asc] http://deb.debian.org/debian trixie main" > /etc/apt/sources.list.d/debian.list && \ 
    echo "deb [arch=${arch} signed-by=/etc/apt/keyrings/debian-keys.asc] http://deb.debian.org/debian-security/ trixie-security main" >> /etc/apt/sources.list.d/debian.list && \
    echo "deb [arch=${arch} signed-by=/etc/apt/keyrings/debian-keys.asc] http://deb.debian.org/debian trixie-updates main" >> /etc/apt/sources.list.d/debian.list
RUN install_packages dumb-init unzip libsnappy1v5 libgtk-3-0 chromium \
    chromium-common chromium-sandbox chromium-sandbox chromium-driver

WORKDIR $APP_HOME
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder $APP_HOME ./

STOPSIGNAL SIGINT
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
USER app
# Users are expected to override the default CMD and set the ENVIRONMENT env
# var and optionally PROFILE to specify a Cucumber profile.
CMD ["cucumber", "--strict-undefined"]
