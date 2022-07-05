#set env vars
set -o allexport; source .env; set +o allexport;
PW_HASH=`htpasswd -nbBC 10 root $ADMIN_PASSWORD | awk -F":" '{print $2}'`

echo "waiting for Uptime-Kuma to be ready ..."
sleep 10;

sqlite3 ./data/kuma.db "INSERT INTO user (id, username, active) VALUES ('1', '${ADMIN_EMAIL}', '1');"
sqlite3 ./data/kuma.db "UPDATE user SET password=\"${PW_HASH}\" WHERE id=1;"
sqlite3 ./data/kuma.db "INSERT INTO notification (id, name, config, active, user_id) VALUES ('1', 'MySmtpAlert', '', '1', '1')"
sqlite3 ./data/kuma.db "UPDATE notification SET config='{\"name\":\"MySmtpAlert\",\"type\":\"smtp\",\"gotifyPriority\":8,\"smtpPort\":25,\"smtpHost\":\"172.17.0.1\",\"smtpFrom\":\"${HOST_DOMAIN}@vm.elestio.app\",\"smtpTo\":\"${ADMIN_EMAIL}\"}' WHERE id=1;"

docker-compose restart