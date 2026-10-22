<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Конструктивний і деструктивний підходи до роботи зі списками"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент</b>: Поляков Єгор Олегович КВ-33</p>
<p align="right"><b>Рік</b>: 2026</p>

## Загальне завдання
Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного списку. Не допускається використання: псевдо-функцій, деструктивних операцій, циклів . Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів).
2. Імперативний варіант реалізації має базуватись на використанні циклів і деструктивних функцій (псевдофункцій). Не допускається використання функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Тим не менш, оригінальний список цей варіант реалізації також не має змінювати, тому перед виконанням деструктивних змін варто застосувати функцію copy-list (в разі необхідності). Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів).

Алгоритм, який необхідно реалізувати, задається варіантом (п. 3.1.1). Зміст і шаблон звіту наведені в п. 3.2.

Кожна реалізована функція має бути протестована для різних тестових наборів. Тести мають бути оформленні у вигляді модульних тестів (наприклад, як наведено у п. 2.3).

## Варіант 2

Алгоритм сортування обміном №1 (без оптимізацій) за незменшенням.

## Лістинг функції з використанням конструктивного підходу
```lisp
(defun exchange (lst r &optional (i 0))
  (cond ((= i r) lst)
        ((> (first lst) (second lst))
         (cons (second lst) (exchange (cons (first lst) (cddr lst)) r (1+ i))))
        (t (cons (first lst) (exchange (rest lst) r (1+ i))))))

(defun sort-1-constructive (lst &optional (r (1- (length lst))))
  (if (< r 1)
      lst
      (sort-1-constructive (exchange lst r) (1- r))))
```

### Тестові набори та утиліти
```lisp
(defun check-sort-1-constructive  (name input expected)
  (format t "~:[FAILED~;passed~]... ~a~%"
            (equal (sort-1-constructive  input) expected) 
            name))

(defun test-sort-1-constructive  ()
  (check-sort-1-constructive  "test 1" '(5 3 8 1 2) '(1 2 3 5 8))
  (check-sort-1-constructive  "test 2" nil nil)
  (check-sort-1-constructive  "test 3" '(7) '(7))
  (check-sort-1-constructive  "test 4" '(1 2 3 4) '(1 2 3 4))
  (check-sort-1-constructive  "test 5" '(4 3 2 1) '(1 2 3 4))
  (check-sort-1-constructive  "test 6" '(3 1 3 2 1) '(1 1 2 3 3))
  (check-sort-1-constructive  "test 7" '(-2 5 0 -7 3) '(-7 -2 0 3 5)))
```

### Тестування
```lisp
(test-sort-1-constructive)
passed... test 1
passed... test 2
passed... test 3
passed... test 4
passed... test 5
passed... test 6
passed... test 7
NIL
```

## Лістинг функції з використанням деструктивного підходу

```lisp
(defun sort-1-destructive (lst)
  (let ((result (copy-list lst)))
    (do ((r (1- (length result)) (1- r))) ((< r 1) result)
      (do ((tail result (cdr tail)) (i 0 (1+ i))) ((= i r))
        (when (> (car tail) (cadr tail))
          (rotatef (car tail) (cadr tail)))))))
```

### Тестові набори та утиліти
```lisp
(defun check-sort-1-destructive (name input expected)
  (format t "~:[FAILED~;passed~]... ~a~%"
            (equal (sort-1-destructive input) expected) 
            name))

(defun test-sort-1-destructive ()
  (check-sort-1-destructive "test 1" '(5 3 8 1 2) '(1 2 3 5 8))
  (check-sort-1-destructive "test 2" nil nil)
  (check-sort-1-destructive "test 3" '(7) '(7))
  (check-sort-1-destructive "test 4" '(1 2 3 4) '(1 2 3 4))
  (check-sort-1-destructive "test 5" '(4 3 2 1) '(1 2 3 4))
  (check-sort-1-destructive "test 6" '(3 1 3 2 1) '(1 1 2 3 3))
  (check-sort-1-destructive "test 7" '(-2 5 0 -7 3) '(-7 -2 0 3 5)))
```

### Тестування
```lisp
(test-sort-1-destructive)
passed... test 1
passed... test 2
passed... test 3
passed... test 4
passed... test 5
passed... test 6
passed... test 7
NIL
```