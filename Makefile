all:
	luarocks make

test:
	docker-compose run --rm test

lint:
	docker-compose run --rm lint

clean:
	find . -name '*~' -delete

.PHONY: lint test all example5 clean
