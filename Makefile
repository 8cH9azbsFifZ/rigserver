build:
	docker build . -t rigserver
	docker build . -t asdlfkj31h/rigserver:0.1

run:
	docker run --rm -it -e 3002:3002 -e 3003:3003 rigserver 


push:
	docker push asdlfkj31h/rigserver:0.1
