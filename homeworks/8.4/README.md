# Домашнее задание к занятию "08.04 Создание собственных modules"

## Подготовка к выполнению
1. Создайте пустой публичных репозиторий в любом своём проекте: `my_own_collection`
2. Скачайте репозиторий ansible: `git clone https://github.com/ansible/ansible.git` по любому удобному вам пути
```
vagrant@test1:~/homeworks/devops-netology/homeworks/8.4$ git clone https://github.com/ansible/ansible.git
Cloning into 'ansible'...
remote: Enumerating objects: 579166, done.
remote: Counting objects: 100% (2/2), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 579166 (delta 0), reused 0 (delta 0), pack-reused 579164
Receiving objects: 100% (579166/579166), 209.85 MiB | 3.24 MiB/s, done.
Resolving deltas: 100% (388782/388782), done.
vagrant@test1:~/homeworks/devops-netology/homeworks/8.4$

```

3. Зайдите в директорию ansible: `cd ansible`
```
vagrant@test1:~$ cd ~/8.4/ansible
```
4. Создайте виртуальное окружение: `python3 -m venv venv`
```
vagrant@test1:~/8.4/ansible$ sudo  apt install python3.8-venv
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following packages were automatically installed and are no longer required:
  ieee-data libasyncns0 libcaca0 libflac8 libgsoap-2.8.91 liblzf1 libopus0 libpulse0 libqt5opengl5 libsdl1.2debian
  libsndfile1 libvncserver1 libvorbisenc2 libvpx6 net-tools python3-argcomplete python3-dnspython python3-libcloud
  python3-lockfile python3-netaddr python3-selinux virtualbox-dkms
Use 'sudo apt autoremove' to remove them.
The following NEW packages will be installed:
  python3.8-venv
0 upgraded, 1 newly installed, 0 to remove and 230 not upgraded.
Need to get 5,448 B of archives.
After this operation, 27.6 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 python3.8-venv amd64 3.8.10-0ubuntu1~20.04.4 [5,448 B]
Fetched 5,448 B in 1s (5,490 B/s)
Selecting previously unselected package python3.8-venv.
(Reading database ... 215766 files and directories currently installed.)
Preparing to unpack .../python3.8-venv_3.8.10-0ubuntu1~20.04.4_amd64.deb ...
Unpacking python3.8-venv (3.8.10-0ubuntu1~20.04.4) ...
Setting up python3.8-venv (3.8.10-0ubuntu1~20.04.4) ...

vagrant@test1:~/8.4/ansible$ python3 -m venv venv

```

5. Активируйте виртуальное окружение: `. venv/bin/activate`. Дальнейшие действия производятся только в виртуальном окружении
```
vagrant@test1:~/8.4/ansible$ . venv/bin/activate
(venv) vagrant@test1:~/8.4/ansible$
```

6. Установите зависимости `pip install -r requirements.txt`
```
(venv) vagrant@test1:~/8.4/ansible$ pip install -r requirements.txt
Collecting jinja2>=3.0.0
  Downloading Jinja2-3.1.2-py3-none-any.whl (133 kB)
     |████████████████████████████████| 133 kB 1.0 MB/s
Collecting PyYAML>=5.1
  Downloading PyYAML-6.0-cp38-cp38-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_12_x86_64.manylinux2010_x86_64.whl (701 kB)
     |████████████████████████████████| 701 kB 4.9 MB/s
Collecting cryptography
  Downloading cryptography-37.0.2-cp36-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (4.1 MB)
     |████████████████████████████████| 4.1 MB 7.1 MB/s
Collecting packaging
  Downloading packaging-21.3-py3-none-any.whl (40 kB)
     |████████████████████████████████| 40 kB 5.4 MB/s
Collecting resolvelib<0.9.0,>=0.5.3
  Downloading resolvelib-0.8.1-py2.py3-none-any.whl (16 kB)
Collecting MarkupSafe>=2.0
  Downloading MarkupSafe-2.1.1-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (25 kB)
Collecting cffi>=1.12
  Downloading cffi-1.15.1-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (442 kB)
     |████████████████████████████████| 442 kB 9.3 MB/s
Collecting pyparsing!=3.0.5,>=2.0.2
  Downloading pyparsing-3.0.9-py3-none-any.whl (98 kB)
     |████████████████████████████████| 98 kB 4.9 MB/s
Collecting pycparser
  Downloading pycparser-2.21-py2.py3-none-any.whl (118 kB)
     |████████████████████████████████| 118 kB 8.0 MB/s
Installing collected packages: MarkupSafe, jinja2, PyYAML, pycparser, cffi, cryptography, pyparsing, packaging, resolvelib
Successfully installed MarkupSafe-2.1.1 PyYAML-6.0 cffi-1.15.1 cryptography-37.0.2 jinja2-3.1.2 packaging-21.3 pycparser-2.21 pyparsing-3.0.9 resolvelib-0.8.1

```
7. Запустить настройку окружения `. hacking/env-setup`
```
(venv) vagrant@test1:~/8.4/ansible$ . hacking/env-setup

```

8. Если все шаги прошли успешно - выйти из виртуального окружения `deactivate`
```
(venv) vagrant@test1:~/8.4/ansible$ deactivate
vagrant@test1:~/8.4/ansible$ . venv/bin/activate && . hacking/env-setup
running egg_info
creating lib/ansible_core.egg-info
writing lib/ansible_core.egg-info/PKG-INFO
writing dependency_links to lib/ansible_core.egg-info/dependency_links.txt
writing entry points to lib/ansible_core.egg-info/entry_points.txt
writing requirements to lib/ansible_core.egg-info/requires.txt
writing top-level names to lib/ansible_core.egg-info/top_level.txt
writing manifest file 'lib/ansible_core.egg-info/SOURCES.txt'
reading manifest file 'lib/ansible_core.egg-info/SOURCES.txt'
reading manifest template 'MANIFEST.in'
warning: no files found matching 'SYMLINK_CACHE.json'
warning: no previously-included files found matching 'docs/docsite/rst_warnings'
warning: no previously-included files found matching 'docs/docsite/rst/conf.py'
warning: no previously-included files found matching 'docs/docsite/rst/index.rst'
warning: no previously-included files found matching 'docs/docsite/rst/dev_guide/index.rst'
warning: no previously-included files matching '*' found under directory 'docs/docsite/_build'
warning: no previously-included files matching '*.pyc' found under directory 'docs/docsite/_extensions'
warning: no previously-included files matching '*.pyo' found under directory 'docs/docsite/_extensions'
warning: no files found matching '*.ps1' under directory 'lib/ansible/modules/windows'
warning: no files found matching '*.yml' under directory 'lib/ansible/modules'
warning: no files found matching 'validate-modules' under directory 'test/lib/ansible_test/_util/controller/sanity/validate-modules'
writing manifest file 'lib/ansible_core.egg-info/SOURCES.txt'

Setting up Ansible to run out of checkout...

PATH=/home/vagrant/8.4/ansible/bin:/home/vagrant/8.4/ansible/venv/bin:/home/vagrant/bin:/home/vagrant/yandex-cloud/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/opt/jdk/17.0.3.1/bin
PYTHONPATH=/home/vagrant/8.4/ansible/test/lib:/home/vagrant/8.4/ansible/lib:/home/vagrant/8.4/ansible/test/lib:/home/vagrant/8.4/ansible/lib
MANPATH=/home/vagrant/8.4/ansible/docs/man:/usr/local/man:/usr/local/share/man:/usr/share/man:/opt/jdk/17.0.3.1/man

Remember, you may wish to specify your host file with -i

Done!
```
9. Ваше окружение настроено, для того чтобы запустить его, нужно находиться в директории `ansible` и выполнить конструкцию `. venv/bin/activate && . hacking/env-setup`
```
vagrant@test1:~/8.4/ansible$ . venv/bin/activate && . hacking/env-setup
```

## Основная часть

Наша цель - написать собственный module, который мы можем использовать в своей role, через playbook. Всё это должно быть собрано в виде collection и отправлено в наш репозиторий.

1. В виртуальном окружении создать новый `my_own_module.py` файл
2. Наполнить его содержимым:
```python
#!/usr/bin/python

# Copyright: (c) 2018, Terry Jones <terry.jones@example.org>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_test

short_description: This is my test module

# If this is part of a collection, you need to use semantic versioning,
# i.e. the version is of the form "2.5.0" and not "2.4".
version_added: "1.0.0"

description: This is my longer description explaining my test module.

options:
    name:
        description: This is the message to send to the test module.
        required: true
        type: str
    new:
        description:
            - Control to demo if the result of this module is changed or not.
            - Parameter description can be a list as well.
        required: false
        type: bool
# Specify this value according to your collection
# in format of namespace.collection.doc_fragment_name
extends_documentation_fragment:
    - my_namespace.my_collection.my_doc_fragment_name

author:
    - Your Name (@yourGitHubHandle)
'''

EXAMPLES = r'''
# Pass in a message
- name: Test with a message
  my_namespace.my_collection.my_test:
    name: hello world

# pass in a message and have changed true
- name: Test with a message and changed output
  my_namespace.my_collection.my_test:
    name: hello world
    new: true

# fail the module
- name: Test failure of the module
  my_namespace.my_collection.my_test:
    name: fail me
'''

RETURN = r'''
# These are examples of possible return values, and in general should use other names for return values.
original_message:
    description: The original name param that was passed in.
    type: str
    returned: always
    sample: 'hello world'
message:
    description: The output message that the test module generates.
    type: str
    returned: always
    sample: 'goodbye'
'''

from ansible.module_utils.basic import AnsibleModule


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        name=dict(type='str', required=True),
        new=dict(type='bool', required=False, default=False)
    )

    # seed the result dict in the object
    # we primarily care about changed and state
    # changed is if this module effectively modified the target
    # state will include any data that you want your module to pass back
    # for consumption, for example, in a subsequent task
    result = dict(
        changed=False,
        original_message='',
        message=''
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # if the user is working with this module in only check mode we do not
    # want to make any changes to the environment, just return the current
    # state with no modifications
    if module.check_mode:
        module.exit_json(**result)

    # manipulate or modify the state as needed (this is going to be the
    # part where your module will do what it needs to do)
    result['original_message'] = module.params['name']
    result['message'] = 'goodbye'

    # use whatever logic you need to determine whether or not this module
    # made any modifications to your target
    if module.params['new']:
        result['changed'] = True

    # during the execution of the module, if there is an exception or a
    # conditional state that effectively causes a failure, run
    # AnsibleModule.fail_json() to pass in the message and the result
    if module.params['name'] == 'fail me':
        module.fail_json(msg='You requested this to fail', **result)

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
```
Или возьмите данное наполнение из [статьи](https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_general.html#creating-a-module).

3. Заполните файл в соответствии с требованиями ansible так, чтобы он выполнял основную задачу: module должен создавать текстовый файл на удалённом хосте по пути, определённом в параметре `path`, с содержимым, определённым в параметре `content`.
```
(venv) vagrant@test1:~/8.4/ansible$ nano create_file.py

(venv) vagrant@test1:~/8.4/ansible$ nano payload.json
(venv) vagrant@test1:~/8.4/ansible$ cat payload.json
{
  "ANSIBLE_MODULE_ARGS": {
    "path": "/home/vagrant/simple_file.txt",
    "content": "Some text for record to file\n"
  }
}

```

4. Проверьте module на исполняемость локально.
```
(venv) vagrant@test1:~/8.4/ansible$ (venv) vagrant@test1:~/8.4/ansible$ python -m ansible.modules.create_file payload.json

{"changed": false, "original_message": "", "message": "Some text for record to file\n", "invocation": {"module_args": {"path": "/home/vagrant/simple_file.txt", "content": "Some text for record to file\n"}}}

```
5. Напишите single task playbook и используйте module в нём.
```
(venv) vagrant@test1:~/8.4/ansible$ (venv) vagrant@test1:~/8.4/ansible$ nano site.yaml
(venv) vagrant@test1:~/8.4/ansible$ (venv) vagrant@test1:~/8.4/ansible$ cat site.yaml
---
- name: test create file module
  hosts: localhost
  tasks:
    - name: Create file with some text
      create_file:
        path: ./simple_file.txt
        content: "Smoke on the water\n"
		
(venv) vagrant@test1:~/8.4/ansible$ (venv) vagrant@test1:~/8.4/ansible$ ansible-playbook site.yaml
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are
modifying the Ansible engine, or trying out features under development. This is a rapidly changing source of code and
can become unstable at any point.
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match
'all'

PLAY [test create file module] *****************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Create file with some text] **************************************************************************************
changed: [localhost]

PLAY RECAP *************************************************************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0



```
6. Проверьте через playbook на идемпотентность.
```
(venv) vagrant@test1:~/8.4/ansible$ ansible-playbook site.yaml
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are
modifying the Ansible engine, or trying out features under development. This is a rapidly changing source of code and
can become unstable at any point.
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match
'all'

PLAY [test create file module] *****************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Create file with some text] **************************************************************************************
ok: [localhost]

PLAY RECAP *************************************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
7. Выйдите из виртуального окружения.
```
(venv) vagrant@test1:~/8.4/ansible$ deactivate
```

8. Инициализируйте новую collection: `ansible-galaxy collection init my_own_namespace.my_own_collection`
```
vagrant@test1:~$ cd /tmp/my_own_collection/
vagrant@test1:/tmp/my_own_collection$ ansible-galaxy collection init my_own_namespace.my_own_collection
- Collection my_own_namespace.my_own_collection was created successfully






```
9. В данную collection перенесите свой module в соответствующую директорию.
```
vagrant@test1:/tmp/my_own_collection$ cp ~/8.4/ansible/lib/ansible/modules/create_file.py  my_own_namespace/my_own_collection/plugins/modules/
vagrant@test1:/tmp/my_own_collection$ cd my_own_namespace/my_own_collection/roles

```
10. Single task playbook преобразуйте в single task role и перенесите в collection. У role должны быть default всех параметров module
```
vagrant@test1:/tmp/my_own_collection/my_own_namespace/my_own_collection/roles$ ansible-galaxy role init create_file
- Role create_file was created successfully
vagrant@test1:/tmp/my_own_collection/my_own_namespace/my_own_collection/roles$ nano create_file/defaults/main.yml
vagrant@test1:/tmp/my_own_collection/my_own_namespace/my_own_collection/roles$ cat create_file/defaults/main.yml
---
# defaults file for create-role
path: ./simple_file.txt
content: "Deep purple!\n"


vagrant@test1:/tmp/my_own_collection/my_own_namespace/my_own_collection/roles$ cat create_file/tasks/main.yml
---
# tasks file for create_file
- name: Create file
  my_own_namespace.my_own_collection.create_file:
    path: "{ path }"
    content: "{ content }"
```
11. Создайте playbook для использования этой role.
```
vagrant@test1:/tmp/test$ cat site.yaml
---
  - name: Some play
    hosts: all
    tasks:
      - name: execute module
        my_own_namespace.my_own_collection.create_file:
          path: "/tmp/somefile.txt"
          content: "This is my content"
		  
vagrant@test1:/tmp/test$ cat inventory/prod.yaml
---
all:
  hosts:
    centos:
      ansible_host: 51.250.103.178
```
12. Заполните всю документацию по collection, выложите в свой репозиторий, поставьте тег `1.0.0` на этот коммит.

https://github.com/ZenovAndrew/my_own_collection/tree/1.0.0
13. Создайте .tar.gz этой collection: `ansible-galaxy collection build` в корневой директории collection.
```
vagrant@test1:/tmp/my_own_collection/my_own_namespace/my_own_collection$ ansible-galaxy collection build
```
Created collection for my_own_namespace.my_own_collection at /tmp/my_own_collection/my_own_namespace/my_own_collection/my_own_namespace-my_own_collection-1.0.0.tar.gz



14. Создайте ещё одну директорию любого наименования, перенесите туда single task playbook и архив c collection.

15. Установите collection из локального архива: `ansible-galaxy collection install <archivename>.tar.gz`
```
vagrant@test1:/tmp/test$ ansible-galaxy collection install my_own_namespace-my_own_collection-1.0.0.tar.gz
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Installing 'my_own_namespace.my_own_collection:1.0.0' to '/home/vagrant/.ansible/collections/ansible_collections/my_own_namespace/my_own_collection'
my_own_namespace.my_own_collection:1.0.0 was installed successfully


```
16. Запустите playbook, убедитесь, что он работает.

```


vagrant@test1:/tmp/test$ vagrant@test1:/tmp/test$ ansible-playbook site.yaml -i inventory/prod.yaml

PLAY [Some play] *******************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [centos]

TASK [execute module] **************************************************************************************************
changed: [centos]

PLAY RECAP *************************************************************************************************************
centos                     : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

vagrant@test1:/tmp/test$ ssh 51.250.103.178
[vagrant@centos ~]$ cd /tmp/
[vagrant@centos tmp]$ ll
total 4
-rw-rw-r--. 1 vagrant vagrant 14 Jul  4 19:03 somefile.txt
drwx------. 3 root    root    17 Jul  4 18:52 systemd-private-7958394cd83d48e7ae6e32fc7b89eb1f-chronyd.service-ejnSwH
[vagrant@centos tmp]$ cat somefile.txt
This is my content
```

17. В ответ необходимо прислать ссылку на репозиторий с collection

https://github.com/ZenovAndrew/my_own_collection



## Необязательная часть

1. Реализуйте свой собственный модуль для создания хостов в Yandex Cloud.
2. Модуль может (и должен) иметь зависимость от `yc`, основной функционал: создание ВМ с нужным сайзингом на основе нужной ОС. Дополнительные модули по созданию кластеров Clickhouse, MySQL и прочего реализовывать не надо, достаточно простейшего создания ВМ.
3. Модуль может формировать динамическое inventory, но данная часть не является обязательной, достаточно, чтобы он делал хосты с указанной спецификацией в YAML.
4. Протестируйте модуль на идемпотентность, исполнимость. При успехе - добавьте данный модуль в свою коллекцию.
5. Измените playbook так, чтобы он умел создавать инфраструктуру под inventory, а после устанавливал весь ваш стек Observability на нужные хосты и настраивал его.
6. В итоге, ваша коллекция обязательно должна содержать: clickhouse-role(если есть своя), lighthouse-role, vector-role, два модуля: my_own_module и модуль управления Yandex Cloud хостами и playbook, который демонстрирует создание Observability стека.

