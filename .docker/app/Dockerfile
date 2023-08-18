# Allow base image override
ARG BASE_IMAGE="harbor.k8s.temple.edu/library/ruby:3.1-alpine"

# hadolint ignore=DL3006,DL3026
FROM "${BASE_IMAGE}"

WORKDIR /app

COPY . .

USER root

ARG SECRET_KEY_BASE

# libc6-compat is required for m1 build.
RUN apk add -U --no-cache \
      bash=5.2.15-r5 \
      libc6-compat=1.2.4-r0 \
      libxslt=1.1.38-r0 \
      postgresql14-client=14.8-r0 \
      shared-mime-info=2.2-r5  \
      tzdata=2023c-r1 && \
    apk add -U --no-cache --virtual build-dependencies \
      build-base=0.5-r3 \
      git=2.40.1-r0 \
      libxslt-dev=1.1.38-r0 \
      postgresql14-dev=14.8-r0 \
      nodejs=18.17.0-r0 \
      yarn=1.22.19-r0 && \
    bundle config set --local without "development test" && \
    bundle install --jobs=8 && \
    find "$GEM_HOME" -name yarn.lock -exec rm "{}" \; && \
    cp config/database.yml.k8 config/database.yml && \
    RAILS_ENV=production SECRET_KEY_BASE=$SECRET_KEY_BASE bundle exec rails assets:precompile && \
    rm -rf node_modules && \
    rm -rf tmp/* && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/ && \
    chown nobody -R /app/tmp && \
    chown nobody -R /app/log

USER nobody

ENTRYPOINT [".docker/app/entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]