FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential postgresql-client

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
# https://github.com/nodesource/distributions#installation-instructions
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

# Install yarn for webpacker
RUN npm install -g yarn
RUN yarn install --check-files

ENV APP_HOME /poc-ruby
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN bundle install

CMD ["rails", "server", "--binding", "0.0.0.0"]