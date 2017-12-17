FROM ruby:2.4.3-slim

WORKDIR /usr/src/app
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN apt-get update && apt-get install -y build-essential libsqlite3-dev nodejs

# Use libxml2, libxslt a packages from alpine for building nokogiri
RUN bundle install

COPY . .
EXPOSE 8000
CMD rails server thin -b 0.0.0.0 -p 8000
