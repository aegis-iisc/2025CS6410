(set-logic QF_LIA) ; Quantifier-free Linear Integer Arithmetic

; Declare integer variables representing portions assigned to each person
(declare-const A Real)  ; Portion of cake given to person A
(declare-const B Real)  ; Portion of cake given to person B
(declare-const C Real)  ; Portion of cake given to person C
(declare-const Cake Real) 

; Define the valuation functions for each person (based on portion sizes)
(define-fun vA ((x Int)) Int (* 2 x))  ; Person A values their portion 2x
(define-fun vB ((x Int)) Int (+ x 1))  ; Person B values their portion x+1
(define-fun vC ((x Int)) Int x)        ; Person C values their portion directly x

(assert (>= Cake 1))

;(assert (and (>= Cake 1) (< Cake 3)))
; Constraint 1: Total portions must sum to 1 (entire cake)
(assert (= (+ A B C) Cake))

; Constraint 2: Each person must get at least 1 portion (assuming portions are integers)
(assert (>= A 1))
(assert (>= B 1))
(assert (>= C 1))

; Constraint 3: Proportionality - Each person's valuation should be at least 1/3 of the total cake value
(assert (>= (vA A) (/ 1 3)))
(assert (>= (vB B) (/ 1 3)))
(assert (>= (vC C) (/ 1 3)))

; Constraint 4: Envy-freeness - Each person's valuation of their portion should be greater than or equal to others
(assert (> (vA A) (vA B)))
(assert (>= (vA A) (vA C)))
(assert (>= (vB B) (vB A)))
(assert (>= (vB B) (vB C)))
(assert (>= (vC C) (vC A)))
(assert (>= (vC C) (vC B)))

; Check if the constraints are satisfiable (i.e., can we fairly divide the cake?)
(check-sat)

; If satisfiable, output the model (portion assignments)
(get-model)
