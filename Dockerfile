FROM alpine:3.12
LABEL Maintainer="Dian Hanifudin Subhi <dhanifudin@gmail.com>" \
      Description="MQTT Server using Mosquitto"

RUN apk --no-cache add git supervisor mosquitto openssh

RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN adduser -h /home/iot -s /bin/sh -D iot
RUN echo -n 'iot:PelatihanIOT' | chpasswd

COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN ssh-keygen -A
RUN mkdir /root/.ssh

EXPOSE 22 1883

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
