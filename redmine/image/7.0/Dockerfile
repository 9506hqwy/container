FROM redmine:7.0

WORKDIR /usr/src/redmine

COPY Gemfile.local Gemfile.local

RUN set -eux; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends pandoc; \
    \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    \
    # サブ URL の設定
    { \
        echo "map ENV['RAILS_RELATIVE_URL_ROOT'] || '/' do"; \
        echo "  run Rails.application"; \
        echo "end"; \
    } >> config.ru; \
    \
    echo "Redmine::Utils::relative_url_root = ENV['RAILS_RELATIVE_URL_ROOT']" >> config/environment.rb; \
    \
    # Memcached の設定
    { \
        echo "if ENV['MEMCACHED_SERVER']"; \
        echo "  config.cache_store = :mem_cache_store, ENV['MEMCACHED_SERVER']"; \
        echo "end"; \
    } >> config/additional_environment.rb

# https://www.redmine.org/projects/redmine/wiki/HowTo_Install_Redmine_in_a_sub-URI
# https://www.redmine.org/issues/41754
ENV RAILS_RELATIVE_URL_ROOT=/redmine
