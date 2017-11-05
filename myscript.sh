#!/bin/bash
cd /etc/nginx/sites-available
rm -rf *
cd /etc/nginx/sites-enabled
rm -rf *
cd /var/apps/
int=8000
while IFS='' read -r line || [[ -n "$line" ]]; do
	j=0
	array=()
	for word in $line
	do
		array[((j))]=$word
		((j++))
	done
	cat /var/nginxconf | sed s/s_port/${int}/ | sed s/s_name/${array[0]}/ > /etc/nginx/sites-available/${array[0]}
	ln -s /etc/nginx/sites-available/${array[0]} /etc/nginx/sites-enabled

	PORT=${int} pm2 start ${array[1]} --name "${array[0]}"
	((int++))

done < "/var/apps/sites"

