---
title: "PostgreSQL Snippets"
category: "main"
---

# pg_ctl
```bash
sudo -upostgres /usr/lib/postgresql/9.6/bin/pg_ctl status -D /mnt/postgresql/9.6/main
sudo -upostgres /usr/lib/postgresql/9.6/bin/pg_ctl promote -D /mnt/postgresql/9.6/main
```


# Load Test
* [Determining the right pgbench database size scale](http://archive.is/5UwS6)
* [man pgbench](https://www.postgresql.org/docs/10/pgbench.html)

```
pgbench -i -U username -p port -h host -F 80 -s 2000 dbname

psql=>SELECT pg_size_pretty( pg_database_size('dbname') );

pgbench -U username -p port -h host -P 60 -T 600 -c 20 dbname
```

# Streaming Replication
* [STREAMING-REPLICATION](https://www.postgresql.org/docs/9.6/warm-standby.html#STREAMING-REPLICATION)


# Change user password
```sql
ALTER USER user_name WITH PASSWORD 'new_password';
```


# User sessions
```
SELECT * FROM pg_stat_activity WHERE usename = 'postgres' and state = 'active';
```

# Database Owner
```
ALTER DATABASE target_database OWNER TO new_onwer;
```