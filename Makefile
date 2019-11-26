build:
	docker build . -t rigserver

run:
	docker run --rm -it -e 3002:3002 -e 3003:3003 rigserver 
