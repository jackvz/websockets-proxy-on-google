# ------------------------------------------------------------
# Start with Ubuntu Bionic Beaver
# ------------------------------------------------------------

FROM ubuntu:18.04

RUN apt-get update 
RUN apt-get -y install iptables dnsmasq python-pip uml-utilities net-tools
RUN apt-get clean

COPY docker-image-config/docker-startup.sh switchedrelay.py limiter.py requirements.txt /opt/websockproxy/
COPY docker-image-config/dnsmasq/interface docker-image-config/dnsmasq/dhcp /etc/dnsmasq.d/

EXPOSE $PORT

RUN pip install -r /opt/websockproxy/requirements.txt

WORKDIR /opt/websockproxy/

CMD /opt/websockproxy/docker-startup.sh
