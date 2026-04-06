#!/bin/bash
set -e

# Create nginx temp directories at runtime
mkdir -p /tmp/client_temp /tmp/proxy_temp_path /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp

cd /home/nonroot/www

# Start Nginx web server
echo "Starting web server on port 8080..."
nginx -c /etc/nginx/nginx.conf

# Give nginx time to start
sleep 2

# Check nginx is still running by looking for its pid file
if [ ! -f /tmp/nginx.pid ]; then
    echo "ERROR: Web server failed to start!"
    exit 1
fi

cd /quakejs

echo "Starting QuakeJS server..."

# Build dynamic arguments based on environment variables
ARGS="+set fs_game baseq3 +set dedicated 1 +set fs_cdn localhost:8080"

if [ -n "$SV_FPS" ]; then
    ARGS="$ARGS +set sv_fps $SV_FPS"
fi

if [ -n "$SV_MAXRATE" ]; then
    ARGS="$ARGS +set sv_maxRate $SV_MAXRATE"
fi

exec node build/ioq3ded.js $ARGS +exec server.cfg
