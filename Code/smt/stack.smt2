(set-logic QF_AUFBV) ; Quantifier-Free Arrays and Bit-Vectors (for lists)

; Parameters
(declare-const n Int)         ; Stack capacity
(assert (= n 3))              ; Example: Stack capacity is 3

; Stack representation: an array where each index stores an integer
(declare-const stack (Array Int Int)) 
(declare-const size Int)       ; Tracks the number of elements in the stack

; Constraints: size must be between 0 and n
(assert (>= size 0))
(assert (<= size n))

; Define operations

; PUSH(x): Adds x to the top if the stack is not full
(define-fun push ((x Int) (s (Array Int Int)) (sz Int)) (Array Int Int)
  (ite (< sz n) (store s sz x) s)  ; Push x if not full
)

(define-fun push-size ((sz Int)) Int
  (ite (< sz n) (+ sz 1) sz)   ; Increase size if not full
)

; POP: Removes the top element if stack is not empty
(define-fun pop ((s (Array Int Int)) (sz Int)) (Array Int Int)
  (ite (> sz 0) s s)  ; Stack remains unchanged (no explicit delete needed)
)

(define-fun pop-size ((sz Int)) Int
  (ite (> sz 0) (- sz 1) sz)  ; Decrease size if not empty
)

; TOP: Reads the top element without modifying the stack
(define-fun top ((s (Array Int Int)) (sz Int)) Int
  (ite (> sz 0) (select s (- sz 1)) (-1))  ; Return top or -1 if empty
)

; Example transitions
(declare-const x Int) ; Element to push

; Initial empty stack
(assert (= size 0))

; Push x
(assert (= stack (push x stack size)))
(assert (= size (push-size size)))

; Top operation
(assert (= (top stack size) x))

; Pop operation
(assert (= stack (pop stack size)))
(assert (= size (pop-size size)))

; Check satisfiability
(check-sat)
(get-model)



Sai kiran
Mastan malik
Sai mastan : heat management
Harish NCC 
Tejashri 
accuracy
Physics informed Nonlinear