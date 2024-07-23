
#after you dump you can rewrite the grants with sed
# this example replaces an ip with local host on the file users_bak
# sed -i -- 's/172.24.16.169/localhost/g' users_bak


USER='root'
PASS=""

if [ ! -z "$PASS" ];
then
	mysql -u $USER -p"$PASS" -B -N -e "SELECT user, host FROM user" mysql | grep -v root | tr '\t' ' ' |while read i;do user=`echo $i|cut -f1 -d' '`;host=`echo $i|cut -f2 -d' '`;mysql -u $USER -p"$PASS" -B -N -e"SHOW GRANTS FOR '$user'@'$host'";done > users
else
        mysql -B -N -e "SELECT user, host FROM user" mysql | grep -v root | tr '\t' ' ' |while read i;do user=`echo $i|cut -f1 -d' '`;host=`echo $i|cut -f2 -d' '`;mysql -B -N -e"SHOW GRANTS FOR '$user'@'$host'";done > users
fi
sed -i 's:\\\\_:_:' users
sed -i 's:$:;:' users