

clean:
	sudo rm -rf Gemfile.lock vendor

image:
	docker build  -t rbtum .

run:
	@docker rm rbtum &> /dev/null || true
	docker run -v $$HOME/development/tumble/rb:/app -p 4567:4567 -it --name rbtum rbtum /bin/bash
