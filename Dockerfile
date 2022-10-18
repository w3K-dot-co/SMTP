#
# mETaLmuSicRaDio Dockerfile for SMTP
#
# VERSION               1.0


# Put on the Pot...
FROM debian:latest

MAINTAINER ApoCaLypSe <ApoCaLypSe@DeAThCuLTArMaGeDDon.com>

COPY .bashrc /root

WORKDIR /opt/mETaLcaster

# Add the ingredients...
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget && \
    apt-get install -y exim4-daemon-light && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    find /var/log -type f | while read f; do echo -ne '' > $f; done;

COPY entrypoint.sh /bin/
COPY set-exim4-update-conf /bin/

# Stir it...
RUN chmod a+x /bin/entrypoint.sh && \
    chmod a+x /bin/set-exim4-update-conf

# Serve it...
EXPOSE 25

# Bon Apetit!
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["exim", "-bd", "-q15m", "-v"]
