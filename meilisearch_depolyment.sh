echo "Download meilisearch from https://github.com/meilisearch/meilisearch/releases/latest and\
 save filename meilisearch as a file in the workdir."  

port=7700
key=$(openssl rand -base64 24)
chmod a+x meilisearch                                   

sudo mv meilisearch /usr/bin
cat << EOF > $(pwd)/meilisearch.service
[Unit]
Description=MeiliSearch
After=systemd-user-sessions.service

[Service]
Type=simple
ExecStart=/usr/bin/meilisearch --http-addr 127.0.0.1:$port --env production --master-key $key
[Install]
WantedBy=default.target
EOF

sudo mv meilisearch.service /etc/systemd/system/
cat /etc/systemd/system/meilisearch.service

sudo systemctl enable meilisearch
sudo systemctl start meilisearch
sudo systemctl status meilisearch
