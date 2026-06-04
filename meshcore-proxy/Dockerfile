FROM ghcr.io/rgregg/meshcore-proxy:latest

USER root

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl jq sed && rm -rf /var/lib/apt/lists/*

# Install bashio
RUN curl -J -L -o /tmp/bashio.tar.gz "https://github.com/hassio-addons/bashio/archive/v0.16.2.tar.gz" \
    && mkdir /tmp/bashio && tar zxvf /tmp/bashio.tar.gz --strip 1 -C /tmp/bashio \
    && mv /tmp/bashio/lib /usr/lib/bashio && ln -s /usr/lib/bashio/bashio /usr/bin/bashio

# Force move to root and copy
WORKDIR /
COPY run.sh /run.sh

# 1. Make executable 
# 2. Fix line endings 
# 3. VERIFY: 'ls' will show up in your build logs
RUN chmod a+x /run.sh \
    && sed -i 's/\r$//' /run.sh \
    && ls -la /run.sh

# Clear entrypoint and use absolute path
ENTRYPOINT []
CMD [ "/bin/bash", "/run.sh" ]