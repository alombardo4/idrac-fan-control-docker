FROM ubuntu:latest

RUN apt-get update

RUN apt-get install ipmitool cron -y

COPY crontab /etc/cron.d/dell_idrac_fan_control

RUN chmod 0777 /etc/cron.d/dell_idrac_fan_control

RUN touch /var/log/cron.log

ADD check_temp.sh /opt/check_temp.sh

ADD startup.sh /startup.sh

RUN chmod 0777 /opt/check_temp.sh

RUN chmod 0777 /startup.sh

RUN /usr/bin/crontab /etc/cron.d/dell_idrac_fan_control

# you should override these default values when running. See README.md
#ENV IDRAC_HOST 192.168.1.100
ENV IDRAC_HOST local
#ENV IDRAC_USER root
#ENV IDRAC_PASSWORD calvin
ENV FAN_SPEED 5

CMD /startup.sh && /opt/check_temp.sh && cron && tail -f /var/log/cron.log
