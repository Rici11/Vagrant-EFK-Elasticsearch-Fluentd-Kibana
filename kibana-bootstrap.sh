#!/bin/bash
 
############################################################
### Script to start fluentd, elasticsearch and kibana   ####
### with proxy authentication                           ####
############################################################
 
PATH_ELASTIC=/var/www/elasticsearch-1.1.0/bin
PATH_KIBANA=/opt/logger/kibana3_auth/app.js
PATH_NODE=/usr/bin/node
PATH_FLUENTD=/etc/init.d/td-agent
 
 
case "$1" in start)
echo "[+] Starting fluentd ...."
$PATH_FLUENTD start
 
echo "[+] Starting elasticsearch ..."
nohup $PATH_ELASTIC/elasticsearch &> /dev/null &
 
echo "[+] Starting Kibana ..."
nohup $PATH_NODE $PATH_KIBANA &> /dev/null &
;;
 
stop)
 
echo "[-] Stopping fluentd ..."
$PATH_FLUENTD stop
 
echo "[-] Stopping elasticsearch ..."
PID_ELASTIC=`ps xu | grep java | grep elasticsearch | gawk '{print $2}'`
if [ -n "$PID_ELASTIC" ]; then
        /bin/kill -9 $PID_ELASTIC
else
        echo "[-] Elasticsearch it's not running."     
fi
 
echo "[-] Stopping Kibana ..."
PID_KIBANA=`/bin/pidof node`
if [ -n "$PID_KIBANA" ]; then
        /bin/kill -9 $PID_KIBANA
else
        echo "[-] Kibana it's not running."    
fi
 
;;
 
restart)
 
$0 stop
$0 start
;;
*)
 
echo "Run the script with options {start, stop, restart}"
exit 1
 
;;
 
esac
 
exit 0