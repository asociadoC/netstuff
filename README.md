netstuff
========

Network stuff 

Recognizes remote abuse networks ...

f.e. .. I had some very old forums on some very websites. I suddenly noticed traffic in them, and wrote some cronjobs 
to watch my webservers logs and write all foreigners that try to use a forum (which is not really online ..) 
into a file called "ban.conf".

Did not last very long and I had about 15k ipaddresses collected and thought about what to do with them .. 

I then wrote those handy little script which walks through ban.conf, uniques all the ips, checks if they already exist 
in netranges.txt. If not, it will query whois to findout who belongs to this network/ip, query for the network range 
and put this info into netranges.txt 

It will also count the occurence of this range in netranges.txt which will give you on overview of who 
eats up your traffic ... 

Just take a look at the results from networks.txt, and also netranges.txt ..

I blocked some of the ranges in my servers firewalls and life got very easy since then, since they run a lot more stable.
