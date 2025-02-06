groupid=$1
artifact=$2
version=$3

script_path=$(dirname $(realpath -s $0))

base_path=~/home-monitor
deploy_path=$base_path/$groupid/$artifact/$version
program=$artifact-$version.jar
port="8080"

ln -s $base_path/$program $deploy_path/$program 

bash $script_path/stop.sh


cd $base_path
java -Dspring.profiles.active=prod -Dserver.port=$port -jar $base_path/$program >> $base_path/log/home-monitor-log 2>> $base_path/log/home-monitor-log &
