build:
	docker build . -t rigserver
	docker build . -t asdlfkj31h/rigserver:0.2

run:
	./start_container.sh

push:
	docker push asdlfkj31h/rigserver:0.2
