.PHONY: all build down

all:
	docker compose up -d --build && docker exec control /entrypoint.sh && docker exec -it control bash

build:
	docker compose up -d --build

down:
	docker compose down