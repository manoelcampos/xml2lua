all:
	luarocks make

run:
	docker-compose down && docker-compose build nginx && docker-compose run --rm --service-ports nginx

test:
	docker-compose run --rm test

lint:
	docker-compose run --rm lint

.PHONY: lint test run all
