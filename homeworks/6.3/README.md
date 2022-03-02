# Домашнее задание к занятию "6.3. MySQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

В следующих заданиях мы будем продолжать работу с данным контейнером.


```
root@test1:/home/vagrant/6.3# cat docker-compose.yml
version: "0.1"
services:
  mysql:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: "12345"
    volumes:
      - vol_mysql:/etc/mysql/
      - vol_backup:/backup/
    ports:
      - "3306:3306"


root@test1:/home/vagrant/6.3# docker-compose up -d
Pulling mysql (mysql:8)...
8: Pulling from library/mysql
Digest: sha256:6b8987c74b59b635abd3c5772f5ca0aa8cd9e27f08cb1274fcd1f7ba1489132e
Status: Downloaded newer image for mysql:8
Creating 63_mysql_1 ... done
root@test1:/home/vagrant/6.3# wget https://raw.githubusercontent.com/netology-code/virt-homeworks/master/06-db-03-mysql/test_data/test_dump.sql
root@test1:/home/vagrant/6.3# cp test_dump.sql /var/lib/docker/volumes/vol_backup/_data

root@test1:/home/vagrant/6.3# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                                  NAMES
0293cbef7ec2   mysql:8   "docker-entrypoint.s…"   51 minutes ago   Up 38 minutes   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   63_mysql_1
root@test1:/home/vagrant/6.3# docker exec -it 0293cbef7ec2 mysql -p12345 -e 'CREATE DATABASE test_db;'
mysql: [Warning] Using a password on the command line interface can be insecure.
root@test1:/home/vagrant/6.3# docker exec -it 0293cbef7ec2 mysql -p12345 -e 'source /backup/test_dump.sql' test_db
mysql: [Warning] Using a password on the command line interface can be insecure.

root@test1:/home/vagrant/6.3# apt install mysql-client
root@test1:/home/vagrant/6.3# mysql -h 127.0.0.1 -p12345
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.28 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> \h

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.

For server side help, type 'help contents'

mysql>

mysql> \u test_db
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> \s
--------------
mysql  Ver 8.0.28-0ubuntu0.20.04.3 for Linux on x86_64 ((Ubuntu))

Connection id:          11
Current database:       test_db
Current user:           root@172.17.0.1
SSL:                    Cipher in use is TLS_AES_256_GCM_SHA384
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.28 MySQL Community Server - GPL
Protocol version:       10
Connection:             127.0.0.1 via TCP/IP
Server characterset:    utf8mb4
Db     characterset:    utf8mb4
Client characterset:    utf8mb4
Conn.  characterset:    utf8mb4
TCP port:               3306
Binary data as:         Hexadecimal
Uptime:                 52 min 52 sec

Threads: 2  Questions: 46  Slow queries: 0  Opens: 162  Flush tables: 3  Open tables: 80  Queries per second avg: 0.014
--------------



mysql> select count(*) from orders where price >300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)



```





## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
    
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.

```

mysql> create user 'test'@'localhost' identified by 'test-pass';
Query OK, 0 rows affected (0.01 sec)

mysql> alter user 'test'@'localhost' attribute '{"name":"James", "surname":"Pretty"}';
Query OK, 0 rows affected (0.00 sec)

mysql> alter user 'test'@'localhost' with MAX_QUERIES_PER_HOUR 100 PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3;
Query OK, 0 rows affected (0.01 sec)

mysql> grant select on test_db.orders to 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql>
mysql> select * from INFORMATION_SCHEMA.USER_ATTRIBUTES where user='test';
+------+-----------+----------------------------------------+
| USER | HOST      | ATTRIBUTE                              |
+------+-----------+----------------------------------------+
| test | localhost | {"name": "James", "surname": "Pretty"} |
+------+-----------+----------------------------------------+
1 row in set (0.00 sec)

mysql>

```

## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`


```
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SHOW TABLE STATUS FROM test_db like 'orders';
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| Name   | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time         | Check_time | Collation          | Checksum | Create_options | Comment |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| orders | InnoDB |      10 | Dynamic    |    5 |           3276 |       16384 |               0 |            0 |         0 |              6 | 2022-03-02 08:01:20 | 2022-03-02 08:01:20 | NULL       | utf8mb4_0900_ai_ci |     NULL |                |         |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
1 row in set (0.00 sec)


mysql> alter table orders engine = MyISAM;
Query OK, 5 rows affected (0.04 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> alter table orders engine = InnoDB;
Query OK, 5 rows affected (0.05 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+----------+------------+----------------------------------------------+
| Query_ID | Duration   | Query                                        |
+----------+------------+----------------------------------------------+
|       10 | 0.00222725 | SHOW TABLE STATUS FROM test_db LIKE 'plugin' |
|       11 | 0.00270000 | SHOW TABLE STATUS FROM mysql LIKE 'plugin'   |
|       12 | 0.00148600 | SHOW TABLE STATUS FROM test LIKE 'plugin'    |
|       13 | 0.00370775 | SHOW TABLE STATUS FROM test_db LIKE 'plugin' |
|       14 | 0.00383175 | SHOW TABLE STATUS FROM mysql LIKE 'plugin'   |
|       15 | 0.00025225 | SHOW TABLE STATUS FROM test_db LIKE orders   |
|       16 | 0.00057125 | SELECT DATABASE()                            |
|       17 | 0.00025150 | SHOW TABLE STATUS FROM test_db LIKE orders   |
|       18 | 0.00021050 | SELECT DATABASE()                            |
|       19 | 0.00041400 | SELECT DATABASE()                            |
|       20 | 0.00247900 | SHOW TABLE STATUS FROM test_db               |
|       21 | 0.00009350 | SHOW TABLE STATUS FROM 'test_db'             |
|       22 | 0.00187700 | SHOW TABLE STATUS FROM test_db like 'orders' |
|       23 | 0.03895400 | alter table orders engine = MyISAM           |
|       24 | 0.04153900 | alter table orders engine = InnoDB           |
+----------+------------+----------------------------------------------+
15 rows in set, 1 warning (0.00 sec)
```
## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.


```
root@test1:/home/vagrant# cat /var/lib/docker/volumes/vol_mysql/_data/my.cnf
# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

#
# The MySQL  Server configuration file.
#
# For explanations see
# http://dev.mysql.com/doc/mysql/en/server-system-variables.html

[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

# Custom config should go here
!includedir /etc/mysql/conf.d/
innodb_flush_log_at_trx_commit = 0
innodb_log_buffer_size         = 1M
innodb_buffer_pool_size        = 1400М
innodb_log_file_size           = 100M

```
---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
