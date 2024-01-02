echo "Source: https://www.server-world.info/en/note?os=CentOS_Stream_9&p=postgresql13&f=2"
#echo "Don't forget to change listenAddresses & port (really SUGGEST 5001) in postgresql.conf and modify pg_hba.conf"

PORT=5001

POSTGRESQLCONF_FILE="$(find / -name "postgresql.conf")"
HBA_FILE="$(find / -name "pg_hba.conf")"
echo 'listen_addresses = '*'' >> $POSTGRESQLCONF_FILE
echo 'port = '$PORT'' >> $POSTGRESQLCONF_FILE
echo 'host    all             all             0.0.0.0/0             md5' >> $HBA_FILE

firewall-cmd --add-port=$PORT/tcp --permanent
systemctl reload firewalld

firewall-cmd --add-service=postgresql
firewall-cmd --runtime-to-permanent
firewall-cmd --reload
