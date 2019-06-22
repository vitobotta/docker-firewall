FROM alpine

RUN apk add --no-cache tini iptables

ADD configure-firewall.sh /bin

ENV CHAIN "DOCKER-FIREWALL"
ENV OPEN_PORTS "22,80,443"
ENV ACCEPT_ALL_FROM ""

ENTRYPOINT ["/sbin/tini", "--"]


CMD ["/bin/configure-firewall.sh"]
