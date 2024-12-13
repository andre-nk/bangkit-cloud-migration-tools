#!/bin/sh
docker exec -t postgres pg_dump -U postgres -F c -b -v -f /var/lib/postgresql/data/backup_file.dump postgres
docker cp postgres:/var/lib/postgresql/data/backup_file.dump .
