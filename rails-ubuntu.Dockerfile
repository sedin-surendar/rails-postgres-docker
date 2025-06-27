# 1. Use Ubuntu as the base image
FROM ubuntu:22.04

# 2. Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    TZ=Asia/Kolkata \
    RBENV_ROOT="/root/.rbenv" \
    PATH="/root/.rbenv/bin:/root/.rbenv/shims:$PATH"

# 3. Install system dependencies
RUN apt-get update -qq && apt-get install -y \
    curl gnupg2 build-essential libpq-dev \
    libssl-dev libreadline-dev zlib1g-dev \
    git libsqlite3-dev nodejs yarn tzdata \
    vim libffi-dev libyaml-dev

# 4. Install rbenv and ruby-build
RUN git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT && \
    git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build && \
    $RBENV_ROOT/plugins/ruby-build/install.sh && \
    echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc

# 5. Install Ruby using rbenv
RUN bash -c 'eval "$(rbenv init - bash)" && rbenv install 3.3.0 && rbenv global 3.3.0'

# 6. Install Bundler
RUN gem install bundler

# 7. Set working directory
WORKDIR /app

# 8. Copy Gemfiles first for caching
COPY Gemfile Gemfile.lock ./

# 9. Install gems
RUN bundle install

# 10. Copy entire app
COPY /myapp /app

# 11. Precompile assets (optional)
#RUN bundle exec rake assets:precompile

# 12. Expose port
EXPOSE 3000

# 13. Start Rails server
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0 -p 3000"]
