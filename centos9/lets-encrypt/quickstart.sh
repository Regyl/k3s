#!/bin/bash
echo "Installing Certbot plugin for Let's Encrypt"
echo "Documentation: https://beget.com/ru/kb/how-to/vps/vypusk-i-ustanovka-ssl-sertifikatov-ot-lets-encrypt-na-vps?_gl=1*1wjftdf*FPAU*MTgyMTQ2MDU4My4xNzY1MDY2MTEx*_ga*MTYyMzU5MDk5My4xNzY1MDY2MTEx*_ga_PZJSKZPBP7*czE3Njk1NDc3NTIkbzI3JGcxJHQxNzY5NTQ3ODU5JGoxNCRsMCRoMA..*_fplc*b2RvTk5SdXgzYWRzYmk2R3kxVDZPd0VHbmpuRHpPUE43SUlvbExTZURNUVNxVnNSQ1hwayUyQm04RnFHNTg5YnN2OGN6NW90Tkc4SXdnR1lQekxqaHF5N1RCJTJGVzIwUEJrMGt5QU1jQnhlSDNEMzNGYmFjUkhwTko3JTJGc1BCb0Z3JTNEJTNE#vypusk-i-nastroyka-sertifikata-dlya-veb-serverov-apache-i-nginx:~:text=%D0%94%D0%BB%D1%8F%20%D0%B2%D0%B5%D0%B1%2D%D1%81%D0%B5%D1%80%D0%B2%D0%B5%D1%80%D0%B0-,Nginx,-Nginx%20%E2%80%93%20%D1%8D%D1%82%D0%BE%20%D0%9F%D0%9E"

sudo dnf install epel-release
pid=$!
wait $pid

sudo dnf upgrade
pid=$!
wait $pid

sudo dnf install snapd
pid=$!
wait $pid

sudo systemctl enable --now snapd.socket
pid=$!
wait $pid

sudo ln -s /var/lib/snapd/snap /snap
pid=$!
wait $pid

sudo systemctl start snapd
pid=$!
wait $pid

sudo snap install core
pid=$!
wait $pid

sudo snap refresh core
pid=$!
wait $pid

sudo snap install --classic certbot
pid=$!
wait $pid

sudo ln -s /snap/bin/certbot /usr/bin/certbot
pid=$!
wait $pid

sudo certbot --nginx
pid=$!
wait $pid

echo "Finished!"