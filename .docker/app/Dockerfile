# Allow base image override
ARG BASE_IMAGE="harbor.k8s.temple.edu/library/ruby:3.3-alpine"

# hadolint ignore=DL3006,DL3026
FROM "${BASE_IMAGE}"

WORKDIR /app

COPY . .

USER root

ARG SECRET_KEY_BASE

# gcompat is required for m1 build.
RUN apk add -U --no-cache \
      bash=5.2.37-r0 \
      gcompat=1.1.0-r4 \
      libxslt=1.1.42-r1 \
      postgresql16-client=16.6-r0 \
      shared-mime-info=2.4-r2 \
      tzdata=2024b-r1 && \
    apk add -U --no-cache --virtual build-dependencies \
      build-base=0.5-r3 \
      git=2.47.2-r0 \
      libxslt-dev=1.1.42-r1 \
      postgresql16-dev=16.6-r0 \
      nodejs=22.13.1-r0 \
      yaml=0.2.5-r2 \
      yaml-dev=0.2.5-r2 \
      yarn=1.22.22-r1 && \
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
    chown nobody -R /app/log && \
    ln -s .env.prod .env

USER nobody

ENTRYPOINT [".docker/app/entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
