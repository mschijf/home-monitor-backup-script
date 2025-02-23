if [ -z $1 ]
then
	postfix=_postgres
else
	postfix=$1	
fi

backuptime=$(date +%Y%m%d_%H%M%S)

backupdir=/tmp/home-monitor-backup 
mkdir -p $backupdir
cd $backupdir

docker exec -i home-monitor /usr/local/bin/pg_dump -U home-monitor-app home-monitor > backup.sql
tar -czf backup.tar.gz ./backup.sql

dropbox_target=Backup/home-monitor/${backuptime}${postfix}
~/dropbox-uploader/dropbox_uploader.sh -q upload $backupdir/backup.tar.gz $dropbox_target

echo -n $dropbox_target
echo -n "  "
du $backupdir/backup.tar.gz

rm backup.tar.gz
rm backup.sql
rmdir $backupdir
