# Changelog

## 2.0.0

- Track the latest BedrockConnect release at build time instead of a pinned jar
  (currently 1.69.0, with Minecraft 26.40 support). A specific upstream tag can
  still be pinned via the `BEDROCK_CONNECT_VERSION` build arg.
- The add-on version is now independent of the bundled BedrockConnect version.
- Add a daily workflow that bumps the add-on when a new BedrockConnect release
  is published, so existing installs are offered the update.
- Switch base image from the deprecated `openjdk:11` to `eclipse-temurin:17-jre`.
- Publish prebuilt images to GHCR under `arvinsingla` instead of building on the Home Assistant host.
- Make `iconUrl` optional and validate `port` as a port number.
- Replace the removed `nodb=true` flag with `BC_DB_TYPE=none`.
- Drop the unused `config:rw` mapping.
- Repository moved to <https://github.com/arvinsingla/hassio-bedrock-connect>.

## 1.51.4

- Last release from the upstream [patrikulus/hassio-bedrock-connect](https://github.com/patrikulus/hassio-bedrock-connect) repository.
