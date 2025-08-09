# Base image n8n official
FROM n8nio/n8n:latest

# Switch to root untuk install packages
USER root

# Update dan install dependencies
RUN apk update && \
    apk add --no-cache \
    python3 \
    py3-pip \
    ffmpeg \
    curl \
    wget \
    && rm -rf /var/cache/apk/*

# Install yt-dlp via pip
RUN pip3 install --break-system-packages yt-dlp

# Verify installation
RUN yt-dlp --version && ffmpeg -version

# Create download directory
RUN mkdir -p /tmp/youtube-downloads && \
    chmod 755 /tmp/youtube-downloads

# Switch back to n8n user
USER node

# Set environment variables
ENV NODE_ENV=production

# Expose port
EXPOSE 5678

# Start n8n
CMD ["n8n"]