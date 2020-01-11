FROM ubuntu:latest

RUN apt-get update

RUN apt-get install ipmitool cron -y

COPY crontab /etc/cron.d/fan-control

RUN chmod 0777 /etc/cron.d/fan-control

RUN touch /var/log/cron.log

ADD check-temp.sh /opt/check-temp.sh

ADD startup.sh /startup.sh

RUN chmod 0777 /opt/check-temp.sh

RUN chmod 0777 /startup.sh

RUN /usr/bin/crontab /etc/cron.d/fan-control

# you should override these when running. See README.md
ENV IDRAC_HOST 192.168.1.100
ENV IDRAC_USER root
ENV IDRAC_PW calvin
ENV FANSPEED 0x05
CMD /startup.sh && cron && tail -f /var/log/cron.log