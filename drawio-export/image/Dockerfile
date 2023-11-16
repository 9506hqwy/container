FROM almalinux:9.2-20230718

RUN set -eux; \
    \
    { \
        echo '[google-chrome]'; \
        echo 'name=google-chrome'; \
        echo 'baseurl=https://dl.google.com/linux/chrome/rpm/stable/$basearch'; \
        echo 'enabled=1'; \
        echo 'gpgcheck=1'; \
        echo 'gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub'; \
    } >> /etc/yum.repos.d/google-chrome.repo; \
    \
    dnf install --disableplugin=subscription-manager -y git nodejs google-chrome-stable; \
    dnf clean all; \
    \
    cd /opt; \
    git clone --depth 1 https://github.com/jgraph/draw-image-export2.git; \
    cd draw-image-export2; \
    \
    npm install; \
    \
    dnf remove -y git; \
    dnf remove --noautoremove -y google-chrome-stable

WORKDIR /opt/draw-image-export2

EXPOSE 8000

CMD ["npm", "start"]
