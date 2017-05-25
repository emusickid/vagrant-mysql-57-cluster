#!/bin/bash
#tcpdump -i any host 192.168.205.12 -A | grep ssl-mode
ITERATIONS=$1
for SSL in "ssl-mode=REQUIRED" "ssl-mode=DISABLED" ;
	do
	  STARTTIME=$(date +%s%N)
	  for ((i=0;i<$ITERATIONS; i++));
	  do
	    mysql -h192.168.205.10 -ubenchmark -ppassword --$SSL -e "SELECT '$SSL'" > /dev/null 2>&1
	  done
	  ENDTIME=$(date +%s%N)
	  echo "It takes $((($ENDTIME - $STARTTIME)/1000000)) milliseconds to complete \"$ITERATIONS\" \"$SSL\" connections."
	done


# SELECT 
# 	sbt.variable_value AS tls_version,  
# 	t2.variable_value AS cipher, 
# 	processlist_user AS user, 
# 	processlist_host AS host         
# FROM 
# 	performance_schema.status_by_thread  AS sbt         
# 	INNER JOIN performance_schema.threads AS t ON t.thread_id = sbt.thread_id         
# 	INNER JOIN performance_schema.status_by_thread AS t2 ON t2.thread_id = t.thread_id        
# WHERE sbt.variable_name = 'Ssl_version' and t2.variable_name = 'Ssl_cipher' 
# ORDER BY tls_version;


#ssh tunnel version

#!/bin/bash
#mysql -ubenchmark -p -P 3307 -h127.0.0.1 
ITERATIONS=$1
for HOST in "192.168.205.10" "127.0.0.1 -P 3307" ;
	do
	  STARTTIME=$(date +%s%N)
	  for ((i=0;i<$ITERATIONS; i++));
	  do
	    mysql -h$HOST -ubenchmark -ppassword  --ssl-mode=DISABLED -e "SELECT '$HOST'" > /dev/null 2>&1
	  done
	  ENDTIME=$(date +%s%N)
	  echo "It takes $((($ENDTIME - $STARTTIME)/1000000)) milliseconds to complete \"$ITERATIONS\" \"$HOST\" connections."
	done
