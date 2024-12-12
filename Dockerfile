FROM dockurr/windows

USER 10016
# Set environment variable
ENV VERSION="10"
ENV DISK_SIZE: "100G"
ENV PASSWORD: "B!0031"
ENV REGION: "en-US"
ENV KEYBOARD: "en-US"
# Expose required ports
EXPOSE 8006 3389
