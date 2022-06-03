# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket as s
import time as t
import datetime as dt
import json as j
import yaml as y

f_log = "/home/andrew/scripts/IPmistmatchlog.log"
path = "/home/andrew/scripts/"
srv = {'drive.google.com':'0.0.0.0', 'mail.google.com':'0.0.0.0', 'google.com':'0.0.0.0'}

print('Проверяем сервера:')
print(srv)

while 1==1:
   for host in srv:
      try:
         s.gethostbyname(host)
      except gaierror:
         print('host is down')
      else:
         ip = s.gethostbyname(host)
         if ip != srv[host]:
            with open(f_log,'a') as fl:
               print(str(dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")) +' [ERROR] ' + str(host) +' IP mistmatch: '+srv[host]+' '+ip,file=fl)
            with open(path+host+".json",'w') as jsf:
               json_data= j.dumps({host:ip})
               jsf.write(json_data) 
            with open(path+host+".yaml",'w') as ymf:
               yaml_data= y.dump([{host : ip}])
               ymf.write(yaml_data) 
            srv[host]=ip
   t.sleep(3)
```

### Вывод скрипта при запуске при тестировании:
```
andrew@andrew-virtual-machine:~/scripts$ ./testIP.py
Проверяем сервера:
{'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
andrew@andrew-virtual-machine:~/scripts$ ll | grep json
-rw-rw-r--  1 andrew andrew   37 дек 16 15:25 drive.google.com.json
-rw-rw-r--  1 andrew andrew   33 дек 16 15:25 google.com.json
-rw-rw-r--  1 andrew andrew   37 дек 16 15:25 mail.google.com.json

andrew@andrew-virtual-machine:~/scripts$ cat *.js*
{"drive.google.com": "142.251.1.194"}
{"google.com": "173.194.222.113"}
{"mail.google.com": "173.194.221.18"}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
andrew@andrew-virtual-machine:~/scripts$ ll | grep yaml
-rw-rw-r--  1 andrew andrew   34 дек 16 15:25 drive.google.com.yaml
-rw-rw-r--  1 andrew andrew   30 дек 16 15:25 google.com.yaml
-rw-rw-r--  1 andrew andrew   34 дек 16 15:25 mail.google.com.yaml

andrew@andrew-virtual-machine:~/scripts$ cat *yaml
- drive.google.com: 142.251.1.194
- google.com: 173.194.222.113
- mail.google.com: 173.194.221.18

```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
???
```

### Пример работы скрипта:
???
