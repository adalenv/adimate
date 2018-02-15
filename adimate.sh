#!/bin/bash 
cd /var/www/html/pip;

ch="-s";

if [ "$1" = "$ch" ]; then
	echo "secure";
	url=$2;
    cleanurl=${url#"https://"};
	else
		echo "unsecure";
		url=$1;
		cleanurl=${url#"http://"};
fi


wget -nv -N  --convert-links --random-wait -r -p --level 1 -E -e robots=off -U mozilla $url;

TEST=$(git status);
chrlen=${#TEST};
git diff --quiet; 

a="Site Updated! : Files Changes--  ";
b="Site Updated! : New Files --  ";
c=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1);

if [ $nochanges -eq 0 ]; then
	echo "no diff";
	else
		git commit -a -m "$a$c";
		git push origin master;
fi

if [ $chrlen -le 70 ]; then
		echo 'test';
	else
		echo '* ['$cleanurl'](https://adalenv.github.io/websites/'$cleanurl')' >> README.md
	    git add .;
		git commit -a -m "$b$c  --  $cleanurl";
		git push origin master;
fi

