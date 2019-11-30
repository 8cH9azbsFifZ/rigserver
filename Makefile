build:
	docker build . -t rigserver
	docker build . -t asdlfkj31h/rigserver:0.3
	docker build . -t t20:5000/rigserver
	

run:
	./start_container.sh

push:
	docker push asdlfkj31h/rigserver:0.3
#	docker push t20:5000/rigserver
