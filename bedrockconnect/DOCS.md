# BedrockConnect Add-on

## About

[BedrockConnect](https://github.com/Pugmatt/BedrockConnect) lets Minecraft Bedrock Edition players on consoles — which are locked to the featured server list — connect to arbitrary servers. This add-on runs it inside Home Assistant and builds its server list from the add-on configuration.

## Installation

1. Go to **Settings → Add-ons → Add-on Store**.
2. Click the ⋮ menu (top right) and select **Repositories**.
3. Add `https://github.com/arvinsingla/hassio-bedrock-connect`.
4. Find **BedrockConnect Add-on** in the store and click **Install**.

## Configuration

```yaml
servers:
  - name: "My Server 1"
    address: "server1.example.com"
    port: 19132
    iconUrl: "https://i.imgur.com/nhumQVP.png"
  - name: "My Server 2"
    address: "server2.example.com"
    port: 19132
```

| Option    | Type   | Required | Description                                                  |
| --------- | ------ | -------- | ------------------------------------------------------------ |
| `name`    | string | yes      | Label shown in the server list on your console.               |
| `address` | string | yes      | Hostname or IP of the Bedrock server.                         |
| `port`    | port   | yes      | Bedrock port, usually `19132`.                                |
| `iconUrl` | string | no       | Icon shown next to the entry. Omit for the default icon.      |

The list is written to `/data/bedrock_servers.json` each time the add-on starts, and BedrockConnect reads it via `BC_CUSTOM_SERVERS`. Restart the add-on after changing the configuration.

## Connecting a console

1. Start the add-on and note your Home Assistant host's IP address.
2. On the console's network settings, set the **primary DNS** to that IP (secondary can stay as-is, or use `8.8.8.8`).
3. Restart Minecraft on the console and open any server from the featured list — you'll see your own list instead.

The console and Home Assistant must be on the same local network. Port `19132/udp` must be free on the host: if you already run another Bedrock server or proxy there, change the host-side port mapping in the add-on's **Network** panel.

## Networking notes

- The add-on binds `19132/udp` on the host. Home Assistant OS does not run anything on that port by default.
- No database is used (`BC_DB_TYPE=none`); servers come purely from the add-on configuration.

## Troubleshooting

**Add-on starts but the console still shows the normal server list** — the console isn't resolving through BedrockConnect. Re-check the DNS setting and fully restart the game (not just the world).

**"WARNING: no servers configured" in the log** — the `servers` list is empty; add entries in the Configuration tab and restart.

**Port already in use** — something else on the host owns `19132/udp`. Remap the host port in the add-on's Network panel.

## Support

Issues with this add-on: <https://github.com/arvinsingla/hassio-bedrock-connect/issues>

Issues with BedrockConnect itself: <https://github.com/Pugmatt/BedrockConnect/issues>
