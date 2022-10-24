all:
	luarocks make

test:
	docker-compose run --rm test

lint:
	docker-compose run --rm lint

example5:
	lua example5.lua < people.xml
	lua example5.lua < books.xml

clean:
	find . -name '*~' -delete

.PHONY: lint test all example5 clean
