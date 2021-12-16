
# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | будет возвращено с ошибкой из-за несоответствие типов int и str |
| Как получить для переменной `c` значение 12?  | привести a к строке:       c=str(a)+b |
| Как получить для переменной `c` значение 3?  | привести b к целому числу: c=a+int(b) |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
!/usr/bin/env python3

import os

bash_command = ["cd ~/devops-netology", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
#is_change = False
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено:   ', '')
        print(prepare_result)
#        break

```

### Вывод скрипта при запуске при тестировании:
```
andrew@andrew-virtual-machine:~/scripts$ ./git.py
   homeworks/4.2/README.md

```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys

cmd = os.getcwd()

if len(sys.argv)>=2:
    cmd = sys.argv[1]
bash_command = ["cd "+cmd, "git status 2>&1"]

result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('fatal') != -1:
        print('Каталог '+cmd+' не является GIT репозиторием')    
    if result.find('нет изменений') != -1:
        print('В каталоге '+cmd+' нет именений в GIT репозитории')    
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено: ', '')
        print(cmd+prepare_result)

```

### Вывод скрипта при запуске при тестировании:
```
andrew@andrew-virtual-machine:~/scripts$ ./git2.py ~/devops-netology/

/home/andrew/devops-netology/     homeworks/4.2/README.md

andrew@andrew-virtual-machine:~/scripts$ ./git2.py ~/

 Каталог  /home/andrew/ не является GIT репозиторием

andrew@andrew-virtual-machine:~/scripts$ ./git2.py ~/PycharmProjects/pythonProject/devops-netology_/

 В каталоге  /home/andrew/PycharmProjects/pythonProject/devops-netology_/ нет именений в GIT репозитории



```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket as s
import time as t
import datetime as dt

srv = {'drive.google.com':'0.0.0.0', 'mail.google.com':'0.0.0.0', 'google.com':'0.0.0.0'}

print('Проверяем сервера:')
print(srv)

while 1==1:
   for host in srv:
      try:
         s.gethostbyname(host)
      except socket.gaierror:
         print('host is down')
      else:
         ip = s.gethostbyname(host)
         if ip != srv[host]:
               print(str(dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")) +' [ERROR] ' + str(host) +' IP mistmatch: '+srv[host]+' '+ip)
               srv[host]=ip
   t.sleep(3)
```

### Вывод скрипта при запуске при тестировании:
```
Проверяем сервера:
{'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}
2021-12-16 10:36:33 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 64.233.161.194
2021-12-16 10:36:33 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 173.194.221.19
2021-12-16 10:36:33 [ERROR] google.com IP mistmatch: 0.0.0.0 64.233.165.138
2021-12-16 10:36:39 [ERROR] mail.google.com IP mistmatch: 173.194.221.19 173.194.221.17
2021-12-16 10:36:45 [ERROR] mail.google.com IP mistmatch: 173.194.221.17 173.194.221.83
2021-12-16 10:36:45 [ERROR] google.com IP mistmatch: 64.233.165.138 64.233.165.101
2021-12-16 10:36:51 [ERROR] mail.google.com IP mistmatch: 173.194.221.83 173.194.221.18
2021-12-16 10:36:51 [ERROR] google.com IP mistmatch: 64.233.165.101 64.233.165.100
2021-12-16 10:36:57 [ERROR] mail.google.com IP mistmatch: 173.194.221.18 173.194.221.19
2021-12-16 10:36:57 [ERROR] google.com IP mistmatch: 64.233.165.100 64.233.165.139
2021-12-16 10:37:03 [ERROR] mail.google.com IP mistmatch: 173.194.221.19 173.194.221.17
2021-12-16 10:37:03 [ERROR] google.com IP mistmatch: 64.233.165.139 64.233.165.113
2021-12-16 10:37:09 [ERROR] mail.google.com IP mistmatch: 173.194.221.17 173.194.221.83
2021-12-16 10:37:09 [ERROR] google.com IP mistmatch: 64.233.165.113 64.233.165.102
2021-12-16 10:37:15 [ERROR] mail.google.com IP mistmatch: 173.194.221.83 173.194.221.18
2021-12-16 10:37:15 [ERROR] google.com IP mistmatch: 64.233.165.102 64.233.165.138
2021-12-16 10:37:21 [ERROR] mail.google.com IP mistmatch: 173.194.221.18 173.194.221.19
2021-12-16 10:37:21 [ERROR] google.com IP mistmatch: 64.233.165.138 64.233.165.101
2021-12-16 10:37:27 [ERROR] mail.google.com IP mistmatch: 173.194.221.19 173.194.221.17
2021-12-16 10:37:27 [ERROR] google.com IP mistmatch: 64.233.165.101 64.233.165.100
2021-12-16 10:37:33 [ERROR] mail.google.com IP mistmatch: 173.194.221.17 173.194.221.83
2021-12-16 10:37:33 [ERROR] google.com IP mistmatch: 64.233.165.100 64.233.165.139
2021-12-16 10:37:39 [ERROR] mail.google.com IP mistmatch: 173.194.221.83 173.194.221.18
2021-12-16 10:37:39 [ERROR] google.com IP mistmatch: 64.233.165.139 64.233.165.113
2021-12-16 10:37:45 [ERROR] mail.google.com IP mistmatch: 173.194.221.18 173.194.221.19
2021-12-16 10:37:45 [ERROR] google.com IP mistmatch: 64.233.165.113 64.233.165.102

```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:
```python
???
```

### Вывод скрипта при запуске при тестировании:
```
???
```
