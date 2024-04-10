.PHONY: up
up:
	docker compose up

.PHONY: down
down:
	docker compose down

.PHONY: restore
restore:
	$(MAKE) restore-sql restore-uploads

.PHONY: restore-uploads
restore-uploads:
	./devsupport/lftp-sync-from-prod

.PHONY: restore-sql
restore-sql:
	./devsupport/dump-sql ai.epfl.ch \
	  | sed 's|https://ai.epfl.ch|http://localhost:8088|g' \
	  | docker compose exec -T -i db \
	      mariadb wordpress -u wordpress -psecret
