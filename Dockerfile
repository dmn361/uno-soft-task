FROM cassandra:5.0.5

RUN apt-get update && apt-get install -y openssh-server && mkdir /var/run/sshd && mkdir /root/.ssh
COPY id_ed25519.pub /root/.ssh/authorized_keys
COPY docker-entrypoint.sh /usr/local/bin/
EXPOSE 22 7000 7001 7199 9042 9160
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["cassandra", "-f"]


