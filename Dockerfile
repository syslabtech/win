FROM dockurr/windows

# Set environment variable
ENV VERSION="10"
ENV DISK_SIZE="100G"
ENV PASSWORD="B!0031"
ENV REGION="en-US"
ENV KEYBOARD="en-US"

# Create a non-root user with a UID between 10000 and 20000
RUN net user /add myuser B!0031 /uid:10001 && net localgroup users myuser /add

# Switch to the newly created non-root user
USER 10001

# Expose required ports
EXPOSE 8006 3389/tcp 3389/udp
