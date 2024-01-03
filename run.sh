#!/bin/bash
#Launch dns-server
sudo docker run -d --rm --name=dns-server --net=yayito-net --ip=172.20.0.2 -e https_proxy=${https_proxy} -e http_proxy=${http_proxy}  bind9

#Start service
sudo docker exec -it dns-server /etc/init.d/bind9 start
#Check service
sudo docker exec -it dns-server /etc/init.d/bind9 status


#Launch host 1
sudo docker run -d --rm --name=host1 --net=yayito-net --ip=172.20.0.3 --dns=172.20.0.2 nicolaka/netshoot /bin/sh -c "while :; do sleep 10; done"

#Launch host 2
sudo docker run -d --rm --name=host2 --net=yayito-net --ip=172.20.0.4 --dns=172.20.0.2 nicolaka/netshoot /bin/sh -c "while :; do sleep 10; done"

