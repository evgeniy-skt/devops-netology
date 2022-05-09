#!/usr/bin/env bash
vault write -format=json pki_int/issue/example-dot-com common_name="example.com" ttl="720h" > /home/vagrant/example.com.crt
cat /home/vagrant/example.com.crt | jq -r .data.certificate > /etc/nginx/sites-avaliable/example.com.crt.pem
cat /home/vagrant/example.com.crt | jq -r .data.ca_chain[] >> /etc/nginx/sites-avaliable/example.com.crt.pem
cat /home/vagrant/example.com.crt | jq -r .data.private_key > /etc/nginx/sites-avaliable/example.com.crt.key