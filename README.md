netstuff
========

Network stuff 

Recognizes remote abuse networks ...

f.e. .. I had some very old forums on some very websites. I suddenly noticed traffic in them, and configured
wrote some cronjobs to watch my webservers logs and write all foreigners that try to use a forum (which is not really 
online ..) into a file called "ban.conf".

Did not take long and I had about 15k IPadresses collected and thought about what to do with them .. 

I then wrote those handy little scripts that walks through ban.conf, uniques all ips, checks if they already exist 
in netranges.txt. It will then query whois to findout who belongs to this network, also query for the range, and put
this info into networks.txt

Just take a look at the results from networks.txt, and also netranges.txt ..

