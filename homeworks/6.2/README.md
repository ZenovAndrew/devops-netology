# Домашнее задание к занятию "6.2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.


```
root@test1:/home/vagrant/pgsql# cat docker-compose.yml
version: "0.1"
services:
  postgres:
    image: postgres:12
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
```


## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
```

root@test1:/home/vagrant/pgsql# docker-compose up -d
Creating pgsql_postgres_1 ... done
root@test1:/home/vagrant/pgsql# psql --host=127.0.0.1 --port=5432 -U postgres
Password for user postgres:
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 12.10 (Debian 12.10-1.pgdg110+1))
Type "help" for help.
postgres=# create role "test-admin-user";
CREATE ROLE
postgres=# create database test_db;
CREATE DATABASE
postgres=# \c test_db
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 12.10 (Debian 12.10-1.pgdg110+1))
You are now connected to database "test_db" as user "postgres".
test_db=#


```

- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
```
test_db=# create table orders (id integer PRIMARY KEY, name text, price integer);
CREATE TABLE
test_db=# create table clients (id integer PRIMARY KEY, surname text, country text, order_num integer, FOREIGN KEY (order_num) REFERENCES orders (Id));
CREATE TABLE

```

- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db

```

test_db=# grant all privileges on database test_db TO "test-admin-user";
GRANT
test_db=# GRANT USAGE, CREATE ON SCHEMA public TO "test-admin-user";
GRANT
test_db=# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "test-admin-user";
GRANT
test_db=# \l
                                     List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |       Access privileges
-----------+----------+----------+------------+------------+--------------------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/postgres                  +
           |          |          |            |            | postgres=CTc/postgres         +
           |          |          |            |            | "test-admin-user"=CTc/postgres
(4 rows)

```

- создайте пользователя test-simple-user  

```
test_db=# CREATE ROLE "test-simple-user";
CREATE ROLE

```

- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
```
test_db=# GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE public.clients TO "test-simple-user";
GRANT
test_db=# GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE public.orders TO "test-simple-user";
GRANT
```

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
```
test_db=# \l
                                     List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |       Access privileges
-----------+----------+----------+------------+------------+--------------------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/postgres                  +
           |          |          |            |            | postgres=CTc/postgres         +
           |          |          |            |            | "test-admin-user"=CTc/postgres
(4 rows)

```

- описание таблиц (describe)
```
test_db=# \d clients
                Table "public.clients"
  Column   |  Type   | Collation | Nullable | Default
-----------+---------+-----------+----------+---------
 id        | integer |           | not null |
 surname   | text    |           |          |
 country   | text    |           |          |
 order_num | integer |           |          |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "country_idx" btree (country)
Foreign-key constraints:
    "clients_order_num_fkey" FOREIGN KEY (order_num) REFERENCES orders(id)

test_db=# \d orders
               Table "public.orders"
 Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
 id     | integer |           | not null |
 name   | text    |           |          |
 price  | integer |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_order_num_fkey" FOREIGN KEY (order_num) REFERENCES orders(id)

```
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```
test_db=# \dp
                                      Access privileges
 Schema |  Name   | Type  |         Access privileges          | Column privileges | Policies
--------+---------+-------+------------------------------------+-------------------+----------
 public | clients | table | postgres=arwdDxt/postgres         +|                   |
        |         |       | "test-admin-user"=arwdDxt/postgres+|                   |
        |         |       | "test-simple-user"=arwd/postgres   |                   |
 public | orders  | table | postgres=arwdDxt/postgres         +|                   |
        |         |       | "test-admin-user"=arwdDxt/postgres+|                   |
        |         |       | "test-simple-user"=arwd/postgres   |                   |
(2 rows)
```

- список пользователей с правами над таблицами test_db

```
test_db=# select * from information_schema.table_privileges WHERE grantee in ('test-simple-user','test-admin-user');
 grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy
----------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 postgres | test-admin-user  | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-admin-user  | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRIGGER        | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-admin-user  | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRIGGER        | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
(22 rows)


```



## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

```

test_db=# INSERT INTO orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
INSERT 0 5
test_db=# INSERT INTO clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
INSERT 0 5
test_db=# SELECT * FROM orders;
 id |  name   | price
----+---------+-------
  1 | Шоколад |    10
  2 | Принтер |  3000
  3 | Книга   |   500
  4 | Монитор |  7000
  5 | Гитара  |  4000
(5 rows)

test_db=# SELECT * FROM clients;
 id |       surname        | country | order_num
----+----------------------+---------+-----------
  1 | Иванов Иван Иванович | USA     |
  2 | Петров Петр Петрович | Canada  |
  3 | Иоганн Себастьян Бах | Japan   |
  4 | Ронни Джеймс Дио     | Russia  |
  5 | Ritchie Blackmore    | Russia  |
(5 rows)

test_db=# SELECT COUNT (*) FROM clients;
 count
-------
     5
(1 row)

test_db=# SELECT COUNT (*) FROM orders;
 count
-------
     5
(1 row)
```


## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.
```
postgres=# UPDATE clients SET order_num = 3 WHERE id = 1;
UPDATE 1
postgres=# UPDATE clients SET order_num = 4 WHERE id = 2;
UPDATE 1
postgres=# UPDATE clients SET order_num = 5 WHERE id = 3;
UPDATE 1


```
Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
```
postgres=# SELECT * FROM clients WHERE order_num IS NOT NULL;
 id |       surname        | country | order_num
----+----------------------+---------+-----------
  1 | Иванов Иван Иванович | USA     |         3
  2 | Петров Петр Петрович | Canada  |         4
  3 | Иоганн Себастьян Бах | Japan   |         5
(3 rows)

```
 
Подсказк - используйте директиву `UPDATE`.

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.
```
postgres=# EXPLAIN SELECT * FROM clients WHERE order_num IS NOT NULL;
                        QUERY PLAN
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
   Filter: (order_num IS NOT NULL)
(2 rows)

Запрос отображает примерное время выполнения запроса выборки заказов с ненулевым номером
```


## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
```
root@test1:/home/vagrant/pgsql# docker exec -t pgsql_postgres_1 pg_dump -U postgres test_db -f /backup/dump_test_db.sql
```
Остановите контейнер с PostgreSQL (но не удаляйте volumes).
```
root@test1:/home/vagrant/pgsql# docker stop pgsql_postgres_1
pgsql_postgres_1
root@test1:/home/vagrant/pgsql# docker rm pgsql_postgres_1
pgsql_postgres_1
root@test1:/home/vagrant/pgsql#
```
Поднимите новый пустой контейнер с PostgreSQL.
```
т.к. данные хранятся в volume vol_db удаляем только этот
root@test1:/home/vagrant/pgsql# docker volume ls
DRIVER    VOLUME NAME
local     vol_backup
local     vol_db
root@test1:/home/vagrant/pgsql# docker volume rm vol_db
vol_db
root@test1:/home/vagrant/pgsql#

запускаем контейнер с новым volume 
root@test1:/home/vagrant/pgsql# docker-compose up -d
Creating pgsql_postgres_1 ... done
root@test1:/home/vagrant/pgsql# psql --host=127.0.0.1 --port=5432 -U postgres

убедимся что база чиста
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


```


Восстановите БД test_db в новом контейнере.
```
т.к в новой базе нет test_db, создаем...


root@test1:/home/vagrant/pgsql# docker exec -it pgsql_postgres_1 psql -U postgres -c 'CREATE DATABASE test_db;'
CREATE DATABASE

восстанавливаем БД
root@test1:/home/vagrant/pgsql# docker exec -it pgsql_postgres_1 psql -U postgres -d test_db -f /backup/dump_test_db.sql
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
CREATE TABLE
ALTER TABLE
COPY 5
COPY 5
ALTER TABLE
ALTER TABLE
CREATE INDEX
ALTER TABLE
psql:/backup/dump_test_db.sql:111: ERROR:  role "test-admin-user" does not exist
psql:/backup/dump_test_db.sql:118: ERROR:  role "test-admin-user" does not exist
psql:/backup/dump_test_db.sql:119: ERROR:  role "test-simple-user" does not exist
psql:/backup/dump_test_db.sql:126: ERROR:  role "test-admin-user" does not exist
psql:/backup/dump_test_db.sql:127: ERROR:  role "test-simple-user" does not exist



убедимся что таблицы восстановились 
root@test1:/home/vagrant/pgsql# psql --host=127.0.0.1 --port=5432 -U postgres
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)

postgres=# \c test_db
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 12.10 (Debian 12.10-1.pgdg110+1))
You are now connected to database "test_db" as user "postgres".
test_db=# select * from clients;
 id |       surname        | country | order_num
----+----------------------+---------+-----------
  4 | Ронни Джеймс Дио     | Russia  |
  5 | Ritchie Blackmore    | Russia  |
  1 | Иванов Иван Иванович | USA     |         3
  2 | Петров Петр Петрович | Canada  |         4
  3 | Иоганн Себастьян Бах | Japan   |         5
(5 rows)

test_db=#
```
Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

