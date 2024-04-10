.PHONY: up
up:
	docker compose up

.PHONY: down
down:
	docker compose down

.PHONY: restore
restore:
	./devsupport/lftp-sync-from-prod
