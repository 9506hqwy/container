FROM redhat/ubi10:10.3-1794519911

RUN dnf install --disableplugin=subscription-manager -y https://downloads.aws.com/aws-emulator/packages/aws-emulator/LTS/latest/aws-emulator-x86_64.rpm && \
    dnf clean all && \
    mkdir -p /home/emulator && \
    chown 1000:1000 /home/emulator

USER 1000

ENV HOME=/home/emulator
ENV EMULATOR_TELEMETRY=off

EXPOSE 9297

ENTRYPOINT ["aws-emulator", "-b", "0.0.0.0"]
