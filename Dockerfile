FROM ruby:3.2.2-alpine3.18

# add needed packages
RUN apk add make git g++ ruby-dev tzdata

# Error out if Gemfile was modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /opt/drawbot

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
