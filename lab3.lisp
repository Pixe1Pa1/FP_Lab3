;; Лістинг функції з використанням конструктивного підходу
(defun exchange (lst r &optional (i 0))
  (cond ((= i r) lst)
        ((> (first lst) (second lst))
         (cons (second lst) (exchange (cons (first lst) (cddr lst)) r (1+ i))))
        (t (cons (first lst) (exchange (rest lst) r (1+ i))))))

(defun sort-1-constructive (lst &optional (r (1- (length lst))))
  (if (< r 1)
      lst
      (sort-1-constructive (exchange lst r) (1- r))))

;; Тестові набори та утиліти
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

;; Тестування
(test-sort-1-constructive)


;; Лістинг функції з використанням деструктивного підходу

(defun sort-1-destructive (lst)
  (let ((result (copy-list lst)))
    (do ((r (1- (length result)) (1- r))) ((< r 1) result)
      (do ((tail result (cdr tail)) (i 0 (1+ i))) ((= i r))
        (when (> (car tail) (cadr tail))
          (rotatef (car tail) (cadr tail)))))))

;; Тестові набори та утиліти
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

;; Тестування
(test-sort-1-destructive)
