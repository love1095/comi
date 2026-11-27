#!/bin/sh
# Daily database backup (§24.2). Cron on the host:  15 3 * * *  /opt/comi/deploy/backup.sh >> /var/log/comi-backup.log 2>&1
# Keeps 14 daily dumps locally; set BACKUP_S3 (e.g. s3://comi-backups) with the aws CLI configured to copy off-site.
set -eu
cd "$(dirname "$0")"
STAMP=$(date +%Y%m%d-%H%M)
OUT="backups/comi-$STAMP.dump"
mkdir -p backups
docker compose -f docker-compose.prod.yml exec -T postgres pg_dump -U comi -Fc comi > "$OUT"
test -s "$OUT" || { echo "backup is empty"; exit 1; }
if [ -n "${BACKUP_S3:-}" ]; then aws s3 cp "$OUT" "$BACKUP_S3/" --only-show-errors; fi
find backups -name 'comi-*.dump' -mtime +14 -delete
echo "$(date -Iseconds) ok $OUT $(du -h "$OUT" | cut -f1)"
