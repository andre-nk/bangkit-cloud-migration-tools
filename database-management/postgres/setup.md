# Setup Postgres
Anggaplah Anda sudah ada di direktory postgres
## Mendeploy container
Deploy container dengan perintah:
``` 
docker compose up -d
```
## Mempopulasikan database schema
Memindahkan init.sql ke dalam container
```
docker cp init.sql postgres:/ 
```
Masuk kedalam container postgres
```
docker exec -it postgres bash
```
Di dalam container jalankan perintah berikut:
```
# Membuat database baru
psql -U postgres -c "CREATE DATABASE portier;"

# Menjalankan init.sql dalam database portier
psql -U postgres -d portier -a -f init.sql
```
## Mensetup monitoring agent untuk percona
Masih dalam container, buat user baru. Password boleh diganti.
```
psql -U postgres -d portier -c "CREATE USER pmm WITH SUPERUSER ENCRYPTED PASSWORD '******';"
psql -U postgres -d portier -c "GRANT pg_monitor to pmm"

# Setting agar bisa MD5 local
echo "local   all             pmm                                md5" >> $PGDATA/pg_hba.conf

# Reload
psql -c "select pg_reload_conf()"
```
## Mensetup meilisearch
Jalankan python file
```
python3 sync.py
```
## List Akses port:
Port postgresql: 5432

Port percona: 80

Port meilisearch: 7700
