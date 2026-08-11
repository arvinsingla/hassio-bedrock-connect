#!/bin/bash
set -euo pipefail

# Add-on options written by the Home Assistant Supervisor.
CONFIG_PATH=/data/options.json
SERVERS_PATH=/data/bedrock_servers.json

echo "[bedrockconnect] Preparing server list..."

servers_json=$(jq -c '.servers // []' "${CONFIG_PATH}")
echo "${servers_json}" > "${SERVERS_PATH}"

server_count=$(jq 'length' "${SERVERS_PATH}")
if [ "${server_count}" -eq 0 ]; then
    echo "[bedrockconnect] WARNING: no servers configured. Add some under the add-on Configuration tab."
else
    echo "[bedrockconnect] Wrote ${server_count} server(s) to ${SERVERS_PATH}"
fi

echo "[bedrockconnect] Starting BedrockConnect..."
exec java -Xms256M -Xmx256M -jar BedrockConnect-1.0-SNAPSHOT.jar
