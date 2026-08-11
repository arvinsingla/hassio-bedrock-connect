# BedrockConnect Home Assistant Add-on

[![Builder](https://github.com/arvinsingla/hassio-bedrock-connect/actions/workflows/builder.yaml/badge.svg)](https://github.com/arvinsingla/hassio-bedrock-connect/actions/workflows/builder.yaml)
[![Lint](https://github.com/arvinsingla/hassio-bedrock-connect/actions/workflows/lint.yaml/badge.svg)](https://github.com/arvinsingla/hassio-bedrock-connect/actions/workflows/lint.yaml)

A Home Assistant add-on that runs [BedrockConnect](https://github.com/Pugmatt/BedrockConnect) by Pugmatt.

**TL;DR** — it lets you join your own (or any) Minecraft Bedrock server from a PS4/PS5, Xbox, or Switch, which normally only allow the featured server list.

Each build pulls the **latest BedrockConnect release** at build time, so upstream updates land without editing this repo.

## Installation

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Farvinsingla%2Fhassio-bedrock-connect)

Or manually:

1. In Home Assistant go to **Settings → Add-ons → Add-on Store**.
2. Click the ⋮ menu (top right) → **Repositories**.
3. Add `https://github.com/arvinsingla/hassio-bedrock-connect` and close the dialog.
4. Find **BedrockConnect Add-on** in the store and click **Install**.
5. Configure your server list (see below), then **Start** the add-on.
6. On your console, set the primary DNS to your Home Assistant IP, then join any featured server — you'll land on your own list instead.

Your Home Assistant host and your console must be on the same network. See [DOCS.md](bedrockconnect/DOCS.md) for full configuration details.

## Configuration

```yaml
servers:
  - name: "My Server"
    address: "minecraft.example.com"
    port: 19132
    iconUrl: "https://i.imgur.com/nhumQVP.png"   # optional
```

The add-on converts this into the JSON file BedrockConnect reads at startup, so changes take effect on restart.

## BedrockConnect versions

The image fetches `releases/latest` from upstream when it is built, so you don't track jar versions here. The add-on's own `version` in [config.yaml](bedrockconnect/config.yaml) is independent of the BedrockConnect version.

To pin a specific upstream release — say a new one is broken — uncomment `args` in [build.yaml](bedrockconnect/build.yaml):

```yaml
args:
  BEDROCK_CONNECT_VERSION: "1.69.0"
```

Locally the same knob is `docker build --build-arg BEDROCK_CONNECT_VERSION=1.69.0 .`, and `--no-cache` forces a re-fetch of the jar (Docker caches the download layer by command, not by upstream content).

### Automatic updates

Home Assistant only offers an update when the add-on's own `version` changes, so tracking `latest` isn't enough on its own. The [Upstream update](.github/workflows/upstream-update.yaml) workflow closes that gap — it runs daily and, when Pugmatt publishes a new release:

1. Bumps the patch version in [config.yaml](bedrockconnect/config.yaml).
2. Records the new upstream tag in [UPSTREAM_VERSION](bedrockconnect/UPSTREAM_VERSION), which is how it knows what's already shipped.
3. Adds a [CHANGELOG.md](bedrockconnect/CHANGELOG.md) entry using the upstream release notes.
4. Commits to `main` and dispatches the Builder workflow.

Existing installs then see an update in Home Assistant. You can run it on demand from the **Actions** tab. It skips a release that has no jar asset, and does nothing when the versions already match.

## Credits

- [BedrockConnect](https://github.com/Pugmatt/BedrockConnect) by [Pugmatt](https://github.com/Pugmatt) — the actual proxy doing all the work.
- Forked from [patrikulus/hassio-bedrock-connect](https://github.com/patrikulus/hassio-bedrock-connect), which is no longer maintained.

## License

Apache-2.0 — see [LICENSE](LICENSE).
