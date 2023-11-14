FROM elasticsearch:8.11.0

RUN set -eux; \
    \
    bin/elasticsearch-plugin install analysis-kuromoji; \
    bin/elasticsearch-plugin install analysis-icu; \
    \
    JVM_CONFIG=/usr/share/elasticsearch/config/jvm.options.d/heap_size.options; \
    echo '-Xms256m' >> "${JVM_CONFIG}"; \
    echo '-Xmx256m' >> "${JVM_CONFIG}"; \
    \
    ES_CONFIG=/usr/share/elasticsearch/config/elasticsearch.yml; \
    sed "${ES_CONFIG}" -i -e '/cluster.name:/d'; \
    { \
        echo 'bootstrap.memory_lock: true'; \
        echo 'http.cors.enabled: true'; \
        echo 'http.cors.allow-origin: "*"'; \
        echo 'xpack.security.enabled: false'; \
    } >> "${ES_CONFIG}"
