#!/bin/sh

cleanup() {
  echo "Cleanup..."
  iptables -D INPUT -j $CHAIN
  iptables -F $CHAIN
  iptables -X $CHAIN
  echo "...done."
  exit 0
}

trap cleanup TERM

echo "Configuring firewall..."

iptables -S $CHAIN

if [ 0 -ne $? ]; then
  iptables -N $CHAIN
fi

iptables -F $CHAIN

iptables -A $CHAIN -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A $CHAIN -i lo -j ACCEPT

iptables -A $CHAIN -p tcp --tcp-flags ALL NONE -j DROP
iptables -A $CHAIN -p tcp ! --syn -m state --state NEW -j DROP
iptables -A $CHAIN -p tcp --tcp-flags ALL ALL -j DROP

iptables -A $CHAIN -p tcp --match multiport --dports $OPEN_PORTS -j RETURN

[ -n "$ACCEPT_ALL_FROM" ] && iptables -A $CHAIN -s $ACCEPT_ALL_FROM -j RETURN

iptables -A $CHAIN -j DROP
iptables -S $CHAIN

iptables -A INPUT -j $CHAIN

echo "...done."

while true; do
  sleep 1 &
  wait $!
done

exit 0
