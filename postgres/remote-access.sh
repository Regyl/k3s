echo "Source: https://www.server-world.info/en/note?os=CentOS_Stream_9&p=postgresql13&f=2"
echo "Don't forget to change listenAddresses & port (really SUGGEST 5001) in postgresql.conf and modify pg_hba.conf"
sleep 10

firewall-cmd --add-port=5001/tcp --permanent
systemctl reload firewalld

firewall-cmd --add-service=postgresql
firewall-cmd --runtime-to-permanent
