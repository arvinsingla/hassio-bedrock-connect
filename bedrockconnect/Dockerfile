ARG BUILD_FROM=eclipse-temurin:17-jre
FROM ${BUILD_FROM}

# Which https://github.com/Pugmatt/BedrockConnect release to bundle.
# "latest" (the default) tracks whatever the newest upstream release is at
# build time. Pin to a tag instead when a release needs to be avoided, e.g.
#   docker build --build-arg BEDROCK_CONNECT_VERSION=1.69.0 .
# or by setting `args` in build.yaml.
ARG BEDROCK_CONNECT_VERSION=latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker/brc
WORKDIR /docker/brc

# curl ships with the eclipse-temurin base image.
RUN if [ "${BEDROCK_CONNECT_VERSION}" = "latest" ]; then \
        jar_url="https://github.com/Pugmatt/BedrockConnect/releases/latest/download/BedrockConnect-1.0-SNAPSHOT.jar"; \
    else \
        jar_url="https://github.com/Pugmatt/BedrockConnect/releases/download/${BEDROCK_CONNECT_VERSION}/BedrockConnect-1.0-SNAPSHOT.jar"; \
    fi; \
    echo "Downloading ${jar_url}"; \
    curl -fSL --retry 3 --retry-delay 2 -o BedrockConnect-1.0-SNAPSHOT.jar "${jar_url}" \
    && chmod 644 BedrockConnect-1.0-SNAPSHOT.jar

COPY start.sh ./start.sh
RUN chmod +x ./start.sh

EXPOSE 19132/udp

CMD ["./start.sh"]
