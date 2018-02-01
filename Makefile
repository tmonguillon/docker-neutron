build:
	docker build -t openstack-neutron:master .
rundebug:
	docker run -t -i -d --rm --hostname neutron --name neutron openstack-neutron:master bash
clean:
	docker rm -f neutron
