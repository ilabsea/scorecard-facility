FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app

# Generate version file if available
RUN if [ -d .git ]; then git describe --always > VERSION; fi

# Precompile assets
RUN bundle exec rake assets:precompile RAILS_ENV=production

ENV RAILS_LOG_TO_STDOUT=true
ENV RACK_ENV=production
ENV RAILS_ENV=production
EXPOSE 80

COPY docker/database.yml /app/config/database.yml

CMD ["puma", "-e", "production", "-b", "tcp://0.0.0.0:80"]
