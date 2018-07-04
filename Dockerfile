FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /sports_pool
WORKDIR /sports_pool
COPY Gemfile /sports_pool/Gemfile
COPY Gemfile.lock /sports_pool/Gemfile.lock
RUN bundle install
COPY . /sports_pool