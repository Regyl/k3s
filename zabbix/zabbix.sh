./apache-web-server.sh
pid=$!
wait $pid

./maria-db.sh
pid=$!
wait $pid
