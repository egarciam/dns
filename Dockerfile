FROM ubuntu:bionic

RUN rm -rf /var/lib/apt/lists/* 
RUN apt-get update -o Acquire::CompressionTypes::Order::=gz
RUN apt-get update 
RUN apt-get upgrade

RUN apt-get install -y \
  bind9 \
  bind9utils \
  bind9-doc 
RUN apt-get install -y net-tools \
    iproute2 \
    tcpdump \
    dnsutils \
    iputils-ping \
    vim


# Enable IPv4
RUN sed -i 's/OPTIONS=.*/OPTIONS="-4 -u bind"/' /etc/default/bind9

# Copy configuration files
COPY named.conf.options /etc/bind/
COPY named.conf.local /etc/bind/
COPY db.yayito.local /etc/bind/zones/

RUN mkdir -p /var/log/bind && chown bind /var/log/bind

# Run eternal loop
CMD ["/bin/bash", "-c", "while :; do sleep 10; done"]