FROM alpine:3.19

# Install system dependencies needed for Python and core utilities
RUN apk add --no-cache \
    python3 \
    py3-pip \
    git \
    curl \
    jq \
    bash \
    build-base \
    python3-dev

# Install the UV package manager natively
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    mv /root/.local/bin/uv /usr/local/bin/uv

# Clone the source repository directly into the image
WORKDIR /app
RUN git clone https://github.com/jkingsman/Remote-Terminal-for-MeshCore.git .

# Sync the Python backend environment natively
RUN uv sync

# Fetch the pre-compiled frontend asset directly from the author's release channel
RUN uv run python3 scripts/setup/fetch_prebuilt_frontend.py

# Bring in your execution wrapper
COPY run.sh /run.sh
RUN sed -i 's/\r$//' /run.sh && chmod a+x /run.sh

CMD [ "/run.sh" ]
