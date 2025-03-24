(set-logic QF_LIA) ; Linear Integer Arithmetic

; Declare integer variables representing portions assigned to each person
(declare-const A Real)  ; Portion of cake given to person A
(declare-const B Real)  ; Portion of cake given to person B
(declare-const C Real)  ; Portion of cake given to person C
(declare-const Cake Real) 


(assert (>= Cake 1))

; Constraint 1: Total portions must sum to 1 (entire cake)
(assert (= (+ A B C) Cake))

; Constraint 2: Each person must get at least 1 portion (assuming each portion is integer)
(assert (>= A 1))
(assert (>= B 1))
(assert (>= C 1))

; Ensure all portions are non-negative (cake cannot be negative)
(assert (>= A 0))
(assert (>= B 0))
(assert (>= C 0))

; Check if the constraints are satisfiable (i.e., the cake can be divided fairly)
(check-sat)

; If satisfiable, output the model (portion assignments)
(get-model)
