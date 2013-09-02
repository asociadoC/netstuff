#!/bin/sh

NUMCLASSC=`grep -v "/" ban.conf | awk -F"." '{ print $1"."$2"."$3 }' | wc -l ` 

NETWORKS=networks.txt
NETRANGES=netranges.txt

if [ ! -f $NETWORKS ]; then
	touch $NETWORKS
else
	> $NETWORKS
fi

if [ ! -f $NETRANGES ]; then
	touch $NETRANGES
fi

increaseNum() {
	if grep $1 $NETWORKS >/dev/null 2>&1 ; then
		CNT=`grep $1 $NETWORKS | awk '{ print $1 }'`
		CNTI=$((CNT + 1))
		sed -i -e "s/$CNT $1/$CNTI $1/" $NETWORKS
	else
		echo "1 $1" >> $NETWORKS
	fi
}

writeNet() {
	if ! grep $1 $NETRANGES >/dev/null 2>&1 ; then
		echo "$2 $1" >> $NETRANGES
	fi 
}

for NET in `grep -v "/" ban.conf | grep -v "100.42.229.168" |sort | uniq ` ; do

	echo "Caught IP : $NET "

	QUERY=1

	while read NETWORK ; do 
		NETRANG=`echo $NETWORK | awk '{ print $2 }'`
		NETNAME=`echo $NETWORK | awk '{ print $1 }'`
		if [ ! -z $NETRANG ]; then
			echo -n "Checking $NET against $NETRANG ... "
			if perl test.pl $NET $NETRANG ; then
				echo "net info existing"
				increaseNum $NETNAME
				QUERY=0
				break
			fi
		fi
	done < netranges.txt

	if [ "$QUERY" -eq "1" ]; then
		INFO=`whois -R $NET | grep -i -e "netname\|inetnum\|NetRange\|route"`
	
		if [ $? -eq 1 ] ; then
			echo "trying alternate command"
			INFO=`whois $NET | grep -i -e "netname\|inetnum\|NetRange\|route"`
		fi

		NETNAME=`echo "$INFO " | grep -i netname | awk '{ print $2 }'`

		if [ -z $NETNAME ]; then
			NETNAME=`echo "$INFO " | grep -i owner | awk '{ print $2 }'`
		fi

		NETRANG=`echo "$INFO " | grep -i -e "netrange\|inetnum" | awk -F":" '{ print $2 }' | tr -d [:blank:] | sed q`

		echo "Netname: $NETNAME"
		echo "Netrange: $NETRANG"
		increaseNum $NETNAME
		writeNet "$NETRANG" $NETNAME
	fi
	
	echo
	echo "+-+-+-+-+-+-+-+-+-+-+-+-+-+"
	echo
done

