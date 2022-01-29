echo "Installation of Apache Web server..."
dnf -y install @httpd
pid=$!
wait $pid

systemctl enable --now httpd
pid=$!
wait $pid

systemctl status httpd
echo "Check. It must be active"

