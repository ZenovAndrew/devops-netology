# Домашнее задание к занятию "7.5. Основы golang"

С `golang` в рамках курса, мы будем работать не много, поэтому можно использовать любой IDE. 
Но рекомендуем ознакомиться с [GoLand](https://www.jetbrains.com/ru-ru/go/).  

## Задача 1. Установите golang.
1. Воспользуйтесь инструкций с официального сайта: [https://golang.org/](https://golang.org/).
2. Так же для тестирования кода можно использовать песочницу: [https://play.golang.org/](https://play.golang.org/).
```
Установлено 
```

## Задача 2. Знакомство с gotour.
У Golang есть обучающая интерактивная консоль [https://tour.golang.org/](https://tour.golang.org/). 
Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, 
осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана.  

```
ознакомлен
```

## Задача 3. Написание кода. 
Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода 
на своем компьютере, либо использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные 
у пользователя, а можно статически задать в коде.
    Для взаимодействия с пользователем можно использовать функцию `Scanf`:
    ```
    package main
    
    import "fmt"
    
    func main() {
        fmt.Print("Enter a number: ")
        var input float64
        fmt.Scanf("%f", &input)
    
        output := input * 2
    
        fmt.Println(output)    
    }
    ```
 
 
 ```

ответ:
 
package main

import "fmt"

const f = 0.3048

func main() {

    fmt.Print("Enter a number: ")
	var input, output float64
	fmt.Scanf("%f", &input)
	output = input / f

	fmt.Println(input, "метров в футах =", output)
}

 ```
 
 
2. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
    ```
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    ```
	
	
```
package main

import "fmt"

func main() {
	x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 27}
	fmt.Println("Элементов в массиве:", len(x))
	res := x[1]
	for i := 0; i < len(x); i++ {
		if res > x[i] {
			res = x[i]
		}
	}
	fmt.Println("Минимальное значение в массиве:", res)
}

	
```
	
3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.

В виде решения ссылку на код или сам код. 

```
package main

import "fmt"

func main() {

	fmt.Println("Вычисление чисел кратных 3")
	for i := 1; i < 100; i++ {
		if (i % 3) <= 0 {
			fmt.Println(i)
		}

	}

}
```


## Задача 4. Протестировать код (не обязательно).

Создайте тесты для функций из предыдущего задания. 
```
package main

import (
	"testing"
)

const f = 0.3048

func TestMin(t *testing.T) {
	z := 0.3048 / f

	if z != 1 {
		t.Error("Expected 1, got ", z)
	}
}

```
```
package main

import (
	"testing"
)

func TestMin(t *testing.T) {
	y := []int{27, 15}
	z := y[1]
	for j := 0; j < len(y); j++ {
		if z > y[j] {
			z = y[j]
		}
	}

	if z != 15 {
		t.Error("Expected 15, got ", z)
	}
}


```

```
package main

import (
	"testing"
)

const f = 0.3048

func TestMin(t *testing.T) {
	z := (66 % 3)

	if z != 0 {
		t.Error("Expected 0, got ", z)
	}
}


```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
