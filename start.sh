script_path=$(dirname $(realpath -s $0))

program="home-monitor"
path="home-monitor"
port="8080"

bash $script_path/stop.sh

cd ~/$path
program_version=`ls -1tr $program*.jar | tail -1`
java -Dspring.profiles.active=prod -Dserver.port=$port -jar $program_version >> ./log/$program-log 2>> ./log/$program-log &
