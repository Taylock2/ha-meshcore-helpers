#!/bin/bash
set -e

echo "[Info] Starting Meshcore RemoteTerm add-on"

# Home Assistant saves add-on options to /data/options.json automatically
CONFIG_PATH="/data/options.json"

# 1. Parse Global Settings
export MESHCORE_LOG_LEVEL=$(jq --raw-output '.meshcore_log_level' $CONFIG_PATH)
export MESHCORE_DISABLE_BOTS=$(jq --raw-output '.meshcore_disable_bots' $CONFIG_PATH)

echo "[Info] Log Level configured to: ${MESHCORE_LOG_LEVEL}"

# 2. Parse Authentication (Using strict app variables)
AUTH_USER=$(jq --raw-output '.username // empty' $CONFIG_PATH)
AUTH_PASS=$(jq --raw-output '.password // empty' $CONFIG_PATH)

if [ -n "$AUTH_USER" ] && [ -n "$AUTH_PASS" ]; then
    echo "[Info] Basic HTTP Authentication enabled."
    export MESHCORE_BASIC_AUTH_USERNAME="$AUTH_USER"
    export MESHCORE_BASIC_AUTH_PASSWORD="$AUTH_PASS"
else
    echo "[Info] Basic HTTP Authentication disabled (missing username/password)."
fi

# 3. Connection Type Traffic Cop
CONN_TYPE=$(jq --raw-output '.connection_type' $CONFIG_PATH)
echo "[Info] Primary connection type selected: ${CONN_TYPE}"

if [ "$CONN_TYPE" = "Serial" ]; then
    SERIAL_PORT=$(jq --raw-output '.serial_port // empty' $CONFIG_PATH)
    if [ -n "$SERIAL_PORT" ]; then
        export MESHCORE_SERIAL_PORT="$SERIAL_PORT"
    fi
    export MESHCORE_SERIAL_BAUDRATE=$(jq --raw-output '.serial_baudrate' $CONFIG_PATH)
    echo "[Info] Enforcing Serial transport on ${MESHCORE_SERIAL_PORT:-auto-detect} @ ${MESHCORE_SERIAL_BAUDRATE} baud"

elif [ "$CONN_TYPE" = "TCP" ]; then
    export MESHCORE_TCP_HOST=$(jq --raw-output '.tcp_host' $CONFIG_PATH)
    export MESHCORE_TCP_PORT=$(jq --raw-output '.tcp_port' $CONFIG_PATH)
    echo "[Info] Enforcing TCP transport on ${MESHCORE_TCP_HOST}:${MESHCORE_TCP_PORT}"
fi

# 4. Enforce Persistent SQLite DB inside Home Assistant's /config share
export MESHCORE_DATABASE_PATH="/config/remoteterm/meshcore.db"
if [ ! -d "/config/remoteterm" ]; then
    echo "[Info] Creating persistent storage directory at /config/remoteterm"
    mkdir -p /config/remoteterm
fi

echo "[Info] Handing over execution to Uvicorn..."
cd /app

# Launch natively, trusting standard NPM headers
exec uv run uvicorn app.main:app --host 0.0.0.0 --port 8000 --proxy-headers --forwarded-allow-ips="*"
