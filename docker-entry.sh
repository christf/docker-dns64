#!/bin/sh

cat > /etc/bind/named.conf.options <<EOF
options {
        directory "/var/cache/bind";
        auth-nxdomain no;
        listen-on-v6 { ${DNS64_IP6_LISTEN}; };
        listen-on { ${DNS64_LISTEN}; };
        allow-query { any; };
        dns64 ${DNS64_PREFIX} {
                clients { any; };
        };
};
EOF

if [ "$1" = 'named' ]; then
  echo "Starting named..."
  exec /usr/sbin/named -g
else
  exec "$@"
fi

