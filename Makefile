build:
	docker build -t openstack-neutron:ubuntu-pike-sfc .
rundebug:
	docker run -t -i --rm --hostname neutron --name neutron openstack-neutron:ubuntu-pike-sfc bash
clean:
	docker rm -f neutron
