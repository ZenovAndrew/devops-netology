# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql

```
root@test1:/home/vagrant/6.4# cat docker-compose.yml
version: "0.1"
services:
  postgres:
    image: postgres:13
    environment:
      POSTGRES_DB: "postgres"
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: "12345"
      PGDATA: "/var/lib/postgresql/data/pgdata"
    volumes:
      - vol_backup:/backup
      - vol_db:/var/lib/postgresql/data
    ports:
      - "5432:5432"

root@test1:/home/vagrant/6.4# docker-compose up -d
Pulling postgres (postgres:13)...
13: Pulling from library/postgres
5eb5b503b376: Already exists
daa0467a6c48: Already exists
7cf625de49ef: Already exists
bb8afcc973b2: Already exists
c74bf40d29ee: Already exists
2ceaf201bb22: Already exists
1255f255c0eb: Already exists
12a9879c7aa1: Already exists
0052b4855bef: Pull complete
e1392be26b85: Pull complete
9154b308134e: Pull complete
7e0447003684: Pull complete
3d7ffb6e96a5: Pull complete
Digest: sha256:d4045089323e564ce1cbd7ddcf5d6a258f1d6153a505e2769579c94d53a401eb
Status: Downloaded newer image for postgres:13
Creating 64_postgres_1 ... done
root@test1:/home/vagrant/6.4# docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS         PORTS                                       NAMES
e3aecc9bd2ec   postgres:13   "docker-entrypoint.s…"   5 minutes ago   Up 5 minutes   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   64_postgres_1
  
root@test1:/home/vagrant/6.4# psql --host=127.0.0.1 --port=5432 -U postgres
Password for user postgres:
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6 (Debian 13.6-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
Type "help" for help.

postgres=# \?
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# \c postgres
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6 (Debian 13.6-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
You are now connected to database "postgres" as user "postgres".
postgres=# \dt
Did not find any relations.
postgres=# \c template0
FATAL:  database "template0" is not currently accepting connections
Previous connection kept
postgres=# \dt
Did not find any relations.
postgres=# \c template1
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6 (Debian 13.6-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
You are now connected to database "template1" as user "postgres".
template1=# \dt
Did not find any relations.

#список системных таблиц

template1-# template1-# \dtS
template1-# template1-# \d pg_am
               Table "pg_catalog.pg_am"
  Column   |  Type   | Collation | Nullable | Default
-----------+---------+-----------+----------+---------
 oid       | oid     |           | not null |
 amname    | name    |           | not null |
 amhandler | regproc |           | not null |
 amtype    | "char"  |           | not null |
Indexes:
    "pg_am_name_index" UNIQUE, btree (amname)
    "pg_am_oid_index" UNIQUE, btree (oid)

template1-# \q
root@test1:/home/vagrant/6.4#
```

## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

```


root@test1:/home/vagrant/6.4#  psql --host=127.0.0.1 --port=5432 --username=postgres
Password for user postgres:
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6 (Debian 13.6-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
Type "help" for help.

postgres=# CREATE DATABASE test_database;
CREATE DATABASE
postgres=#  \l
                                   List of databases
     Name      |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
---------------+----------+----------+------------+------------+-----------------------
 postgres      | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0     | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
 template1     | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
 test_database | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)

postgres=# \q
root@test1:/home/vagrant/6.4#
root@test1:/home/vagrant/6.4# wget https://raw.githubusercontent.com/netology-code/virt-homeworks/master/06-db-04-postgresql/test_data/test_dump.sql
root@test1:/home/vagrant/6.4# cp test_dump.sql /var/lib/docker/volumes/vol_backup/


root@test1:/home/vagrant/6.4# docker exec -it e3aecc9bd2ec psql -U postgres -d test_database -f /backup/test_dump.sql
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval
--------
      8
(1 row)

ALTER TABLE
root@test1:/home/vagrant/6.4#
root@test1:/home/vagrant/6.4# psql --host=127.0.0.1 --port=5432 -U postgres
Password for user postgres:
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6 (Debian 13.6-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
Type "help" for help.

postgres=# \c test_database
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6 (Debian 13.6-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
You are now connected to database "test_database" as user "postgres".
test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_database=# analyze public.orders;
ANALYZE
test_database=#
test_database=#
test_database=# analyze verbose public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
test_database=# select avg_width, attname from pg_stats where tablename='orders';
 avg_width | attname
-----------+---------
         4 | id
        16 | title
         4 | price
(3 rows)

test_database=#

```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

```
#Судя по всему преобразовать обычную таблицу в секционированную и наоборот нельзя, поэтому для миграции переименуем существующую таблицу orders, создадим новую с указанием секционирования:

test_database=# alter table orders rename to orders_tmp;
ALTER TABLE
test_database=#
test_database=# create table orders (id integer, title varchar(100), price integer) partition by range(price);
CREATE TABLE
test_database=# create table orders_1 partition of orders for values from (500) to (maxvalue);
CREATE TABLE
test_database=# create table orders_2 partition of orders for values from (minvalue) to (500);
CREATE TABLE
test_database=# \dt
                 List of relations
 Schema |    Name    |       Type        |  Owner
--------+------------+-------------------+----------
 public | orders     | partitioned table | postgres
 public | orders_1   | table             | postgres
 public | orders_2   | table             | postgres
 public | orders_tmp | table             | postgres
(4 rows)

test_database=# insert into orders (id, title, price) select * from orders_tmp;
INSERT 0 8
test_database=# select * from orders_1;
 id |       title        | price
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
(3 rows)

test_database=# select * from orders_2;
 id |        title         | price
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(5 rows)

test_database=#


# Да, можно было бы исключить ручное разбиение при проектировании БД, указав как секционную таблицу


```


## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

```
root@test1:/home/vagrant/6.4# docker exec -it e3aecc9bd2ec pg_dump -U postgres -d test_database -f /backup/test_database.sql
root@test1:/home/vagrant/6.4# cd /var/lib/docker/volumes/vol_backup/_data/
root@test1:/var/lib/docker/volumes/vol_backup/_data# ll
total 20
drwxr-xr-x 2 root root 4096 Mar  2 16:00 ./
drwx-----x 3 root root 4096 Mar  2 15:07 ../
-rw-r--r-- 1 root root 2926 Feb 21 16:10 dump_test_db.sql
-rw-r--r-- 1 root root 3476 Mar  2 16:00 test_database.sql
-rw-r--r-- 1 root root 2082 Mar  2 15:04 test_dump.sql


# Т.к уникальное ограничение для секционированной таблицы должно включать все столбцы секционирования, то возможно следующей командой. 
test_database=# alter table orders add constraint title_unique unique (price,title);
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---












