#!/bin/sh
set -e
PORT_VAL=${PORT:-8080}
UUID_VAL=${UUID:-}
if [ -z "$UUID_VAL" ]; then
  echo "UUID env var is required" >&2
  exit 1
fi
WS_PATH_VAL=${WS_PATH:-/ray}
cat > /tmp/config.json <<EOF
{
  "inbounds": [
    {
      "port": $PORT_VAL,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "$UUID_VAL"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "$WS_PATH_VAL"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF
exec /usr/local/bin/xray run -c /tmp/config.json
