build:
	@docker build -t broken-env:demo .
run:
	@docker run --name broken-env-demo -d -p 8228:8228 --rm -it broken-env:demo 
cleanup:
	@docker container stop broken-env-demo || true
	@docker image rmi -f `docker images -q -f "label=broken_env=true"` || true
	@docker image rm -f broken-env
test: 
	@sh ./test.sh