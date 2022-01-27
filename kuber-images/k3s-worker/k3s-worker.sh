TOKEN=K10333a2b6a75c9c897778e8a3360034ba636cc36430c87257c08566bad7c60d079::server:e45d4c6270f073ba33550d5bf3afae69
URL=195.2.214.167
echo "Don't forget to change variables!!!"
curl -sfL https://get.k3s.io | K3S_URL=https://$URL:6443 K3S_TOKEN=$TOKEN sh -"
