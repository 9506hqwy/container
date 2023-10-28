FROM redmine:4.2-passenger

WORKDIR /usr/src/redmine

COPY Gemfile.local Gemfile.local

RUN set -eux; \
    \
    savedAptMark="$(apt-mark showmanual)"; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends build-essential=12.9; \
    \
    rm -rf /var/lib/apt/lists/*; \
    \
    bundle install; \
    \
    # すべてのパッケージを自動に変更後にもとのパッケージを手動に変更して
    # インストールしたパッケージを削除する。
    apt-mark auto '.*' > /dev/null; \
    [ -z "${savedAptMark}" ] || apt-mark manual ${savedAptMark}; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

RUN set -eux; \
    \
    # サブ URL の設定
    { \
        echo "map ENV['REDMINE_SUB_URL'] || '/' do"; \
        echo "  run Rails.application"; \
        echo "end"; \
    } >> config.ru; \
    \
    echo "Redmine::Utils::relative_url_root = ENV['REDMINE_SUB_URL']" >> config/environment.rb; \
    \
    # Memcached の設定
    { \
        echo "if ENV['MEMCACHED_SERVER']"; \
        echo "  config.cache_store = :mem_cache_store, ENV['MEMCACHED_SERVER']"; \
        echo "end"; \
    } >> config/additional_environment.rb

ENV REDMINE_SUB_URL=/redmine

RUN ln -s /usr/src/redmine/public /usr/src/redmine/public${REDMINE_SUB_URL}
