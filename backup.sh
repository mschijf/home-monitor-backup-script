if [ -z $1 ]
then
	postfix=_postgres
else
	postfix=$1	
fi

if [ -z $2 ]
then
	keep=672
else
	keep=$2
fi

backuptime=$(date +%Y%m%d_%H%M%S)

backupdir=/tmp/home-monitor-backup 
mkdir $backupdir
cd $backupdir

echo "Starting backup with postfix '$postfix' and keeping last $keep backups"

docker exec -i home-monitor /usr/local/bin/pg_dump -U home-monitor-app home-monitor > backup.sql
tar -czf backup.tar.gz ./backup.sql

echo -n $(date '+%Y-%m-%d %H:%M:%S')  
echo -n '  '
du backup.tar.gz
~/dropbox-uploader/dropbox_uploader.sh upload $backupdir/backup.tar.gz Backup/home-monitor/${backuptime}${postfix}

script_path=$(dirname $(realpath -s $0))
$script_path/cleanup_backup.sh $postfix $keep 

rm backup.tar.gz
rm backup.sql
rmdir $backupdir
