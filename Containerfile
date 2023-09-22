FROM docker.io/library/ruby:3.1.3

COPY . /app/
WORKDIR /app/

RUN \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -y  yarn && \
  \
  bundle install && \
  yarn install --check-files && \
  rails db:migrate

EXPOSE 8080
ENTRYPOINT ["unicorn"]
