#!/usr/bin/env bash
set -e

# Manually load the bashio library
# This is the secret sauce for non-official base images
source /usr/lib/bashio/bashio.sh

# Now bashio::config will work
SERIAL=$(bashio::config 'serial_port')
BAUD=$(bashio::config 'baud_rate')
if [ -z "$SERIAL" ] || [ "$SERIAL" == "null" ]; then
    bashio::log.warning "Serial port not set in config, defaulting to /dev/ttyUSB0"
    SERIAL="/dev/ttyUSB0"
fi

if [ -z "$BAUD" ] || [ "$BAUD" == "null" ]; then
    bashio::log.warning "Baud rate not set in config, defaulting to 115200"
    BAUD="115200"
fi

bashio::log.info "Starting MeshCore Proxy on ${SERIAL} with baud rate ${BAUD}"

# Use the full path to ensure we bypass any alias issues
exec /usr/local/bin/meshcore-proxy --serial "${SERIAL}" --port 5000 --host 0.0.0.0 --baud "${BAUD}"
