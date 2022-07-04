#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./data;
chown -R 1001:1001 ./data;

apt install apache2-utils sqlite3 -y
