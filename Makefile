.PHONY: up
up:
	docker compose up

.PHONY: down
down:
	docker compose down

.PHONY: restore
restore:
	$(MAKE) restore-sql restore-files

.PHONY: restore-files
restore-files:
	./devsupport/lftp-sync-from-prod

CUSTOM_RESTORE_SQLS := $(wildcard devsupport/restore/*.sql)

.PHONY: restore-sql
restore-sql:
	( ./devsupport/dump-sql ai.epfl.ch \
	  | sed 's|https://ai.epfl.ch|http://localhost:8088|g' ; \
	  cat /dev/null $(CUSTOM_RESTORE_SQLS) \
	) | docker compose exec -T -i db \
	      mariadb wordpress -u wordpress -psecret
