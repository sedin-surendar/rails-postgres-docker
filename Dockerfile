# Use official Ruby image
FROM ruby:3.2.2-slim

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    curl \
    tzdata \
    yarn \
    git && \
    rm -rf /var/lib/apt/lists/*

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the whole app
COPY myapp/ /app

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Port the app runs on
EXPOSE 3000

# Start the server
CMD ["rails", "server", "-b", "0.0.0.0"]

