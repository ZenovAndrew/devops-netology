# Домашнее задание к занятию "09.01 Жизненный цикл ПО"

## Подготовка к выполнению
1. Получить бесплатную [JIRA](https://www.atlassian.com/ru/software/jira/free)
2. Настроить её для своей "команды разработки"
3. Создать доски kanban и scrum

## Основная часть
В рамках основной части необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить следующий жизненный цикл:
1. Open -> On reproduce
2. On reproduce <-> Open, Done reproduce
3. Done reproduce -> On fix
4. On fix <-> On reproduce, Done fix
5. Done fix -> On test
6. On test <-> On fix, Done
7. Done <-> Closed, Open

Остальные задачи должны проходить по упрощённому workflow:
1. Open -> On develop
2. On develop <-> Open, Done develop
3. Done develop -> On test
4. On test <-> On develop, Done
5. Done <-> Closed, Open

Создать задачу с типом bug, попытаться провести его по всему workflow до Done. Создать задачу с типом epic, к ней привязать несколько задач с типом task, провести их по всему workflow до Done.
При проведении обеих задач по статусам использовать kanban. Вернуть задачи в статус Open.
Перейти в scrum, запланировать новый спринт, состоящий из задач эпика и одного бага, стартовать спринт, провести задачи до состояния Closed. Закрыть спринт.

Если всё отработало в рамках ожидания - выгрузить схемы workflow для импорта в XML. Файлы с workflow приложить к решению задания.

---


### Ответ

Для выполнения использовал VPN. Порядок выполнения следующий: 

После регистрации Jira предложила создать проект. 
![](pics/1.png)

Идем в настройки (шестерёнка в правом углу) -> Задачи. Попадаем на страницу с Типами задач. 

![](pics/2.png)

Далее переходим в раздел Бизнес-процессы и создаём процессы:
![](pics/3.png)

![](pics/4.png)

Переходим схемы бизнес-процессов, создаем схему и привязываем типы задач к соответсующим бизнес-процессам.
![](pics/5.png)

Далее возникли ошибки. При создании нового проекта "По какой-то причине нужный результат не был достигнут. Нажмите «Создать», чтобы попробовать еще раз."
При создании доски - Ошибка. Внутренняя ошибка сервера.
При создании задачи - Что-то пошло не так. Произошла ошибка. Обновите страницу и повторите попытку.

Пришлось создать новую учетку jira...

Далее создаем доску кабан (поиск -> доски -> создать доску -> kanban)

Далее нужно переключить бизнес процесс на наш. Заходим в настройки проекта -> Бизнес-процессы ->переключить схему
Далее нужно настроить доску Kanban. Переходим в доска Kanban -> ... -> настройки доски ->столбцы.  Настраиваем свои статусы столбцам
![](pics/6.png)

Создаем задачу с типом баг и проводим ее по статусам. При изменении статуса задача перемешается по доске
![](pics/7.png)
Создаем задачу с типом эпик и привязываем насколько задач с типом task
![](pics/8.png)
Возвращаем задачи в статус открыть и создаем доску scram
Далее переходим в бэклог и создаем спринт. Перетягиваем задачи и запускаем спринт
Настраиваем доску аналогично kanban
Проводим задачи по статусам. При изменении статуса задача перемешается по доске
![](pics/9.png)
Все работает. Выгружаем схемы процессов в xml 

[bugs](bugs_flow.xml)
[tasks](tasks_flow.xml)

