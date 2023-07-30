sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
pid=$!
wait $pid

sudo yum install -y postgresql15-server
pid=$!
wait $pid

sudo /usr/pgsql-15/bin/postgresql-15-setup initdb
pid=$!
wait $pid

sudo systemctl enable postgresql-15
pid=$!
wait $pid

sudo systemctl start postgresql-15
pid=$!
wait $pid

echo "Run \password to change superuser password"
echo "And then run show hba_file;"
echo "And then change as said here from peer to md5: https://stackoverflow.com/questions/18664074/getting-error-peer-authentication-failed-for-user-postgres-when-trying-to-ge"
sleep 10 
sudo -u postgres psql
