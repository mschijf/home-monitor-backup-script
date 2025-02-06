backuptime=$(date +%Y%m%d_%H%M%S)

mkdir ~/tmp_backup
cd ~/tmp_backup

docker exec -i home-monitor /usr/local/bin/pg_dump -U home-monitor-app home-monitor > backup_postgres.sql
tar -czf backup_postgres.tar.gz ./backup_postgres.sql

echo -n $(date '+%Y-%m-%d %H:%M:%S')  
echo -n '  '
du -h0 backup_postgres.tar.gz
echo -n '  '
~/dropbox-uploader/dropbox_uploader.sh upload ~/tmp_backup/backup_postgres.tar.gz Backup/home-monitor/${backuptime}_postgres
~/home-monitor-script/cleanup_backup.sh _postgres 672

rm backup_postgres.tar.gz
rm backup_postgres.sql
rmdir ~/tmp_backup
