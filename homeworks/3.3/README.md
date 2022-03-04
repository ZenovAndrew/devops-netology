# Домашнее задание к занятию "3.3. Операционные системы, лекция 1"

1. Какой системный вызов делает команда `cd`? В прошлом ДЗ мы выяснили, что `cd` не является самостоятельной  программой, это `shell builtin`, поэтому запустить `strace` непосредственно на `cd` не получится. Тем не менее, вы можете запустить `strace` на `/bin/bash -c 'cd /tmp'`. В этом случае вы увидите полный список системных вызовов, которые делает сам `bash` при старте. Вам нужно найти тот единственный, который относится именно к `cd`.
```
andrew@andrew-virtual-machine:~$ strace /bin/bash -c 'cd /tmp' 2>&1 
chdir("/tmp")

```
2. Попробуйте использовать команду `file` на объекты разных типов на файловой системе. Например:
    ```bash
    vagrant@netology1:~$ file /dev/tty
    /dev/tty: character special (5/0)
    vagrant@netology1:~$ file /dev/sda
    /dev/sda: block special (8/0)
    vagrant@netology1:~$ file /bin/bash
    /bin/bash: ELF 64-bit LSB shared object, x86-64
    ```
    Используя `strace` выясните, где находится база данных `file` на основании которой она делает свои догадки.
```
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
```
3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).
```
andrew@andrew-virtual-machine:~$ lsof |grep deleted
mate-term 1857                         andrew   13u      REG                8,5 13959168     416112 /tmp/#416112 (deleted
andrew@andrew-virtual-machine:~$ ls -l /proc/1857/fd | grep "/tmp/#416112"
lrwx------ 1 andrew andrew 64 ноя 17 14:17 13 -> /tmp/#416112 (deleted)
В итоге полный путь до файлового дескриптора удаленного файла выглядит так:
/proc/1857/fd/13
andrew@andrew-virtual-machine:~$ truncate -s 0 /proc/1857/fd/13
Место освобождено

```
4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?
```
Зомби процессы не используют какие-либо ресурсы, но присутствуют в списке процессов операционной системы чтобы дать родительскому процессу считать код завершения.
```

5. В iovisor BCC есть утилита `opensnoop`:
    ```bash
    root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
    /usr/sbin/opensnoop-bpfcc
    ```
    На какие файлы вы увидели вызовы группы `open` за первую секунду работы утилиты? Воспользуйтесь пакетом `bpfcc-tools` для Ubuntu 20.04. Дополнительные [сведения по установке](https://github.com/iovisor/bcc/blob/master/INSTALL.md).

```
Если правильно понял вопрос, то: 
1418   mate-settings-d    22   0 PID    COMM               FD ERR PATH
/etc/fstab
1418   mate-settings-d    22   0 /proc/self/mountinfo
1418   mate-settings-d    22   0 /run/mount/utab
1418   mate-settings-d    22   0 /proc/self/mountinfo
1418   mate-settings-d    22   0 /run/mount/utab
759    vmtoolsd            9   0 /etc/mtab
759    vmtoolsd           11   0 /proc/devices

```

6. Какой системный вызов использует `uname -a`? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в `/proc`, где можно узнать версию ядра и релиз ОС.
```
Part of the utsname information is also accessible  via  /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}. 
```
7. Чем отличается последовательность команд через `;` и через `&&` в bash? Например:
    ```bash
    root@netology1:~# test -d /tmp/some_dir; echo Hi
    Hi
    root@netology1:~# test -d /tmp/some_dir && echo Hi
    root@netology1:~#
    ```
    Есть ли смысл использовать в bash `&&`, если применить `set -e`?
```
В первом случае команды выполнятся последовательно, а во втором команда «echo Hi» отработает только после успешного выполнения первой команды. 
«set –e» - прерывает команду при любом ненулевом значении исполняемых команд.
в случае &&  вместе с set -e- конструкция бессмысленна, т.к. последняя команда к конвейере будет выполняться всегда

```
8. Из каких опций состоит режим bash `set -euxo pipefail` и почему его хорошо было бы использовать в сценариях?
```
-e прерывает выполнение при ненулевом статусе 
-x вывод команд и их аргументов при выполнении 
-u не заданные параметры и переменные считаются как ошибки
-o pipefail возвращает ненулевой код возврата при выполнении последней команды, или 0 при успешном выполнении всех команд.
В сценариях это повышает детализацию вывода ошибок, и информативности выполнения каждой команды в последовательности команд.


```
9. Используя `-o stat` для `ps`, определите, какой наиболее часто встречающийся статус у процессов в системе. В `man ps` ознакомьтесь (`/PROCESS STATE CODES`) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).
```

R    - запущенные или запускаемые
S    - спящие или ожидающие завершения

```
 