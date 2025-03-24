(set-logic QF_NRA)  ; Quantifier-Free Nonlinear Real Arithmetic

; Declare the number of pieces
(declare-const P Int)  

; Declare the size of each piece (assuming max 6 pieces)
(declare-const s1 Real)
(declare-const s2 Real)
(declare-const s3 Real)
(declare-const s4 Real)
(declare-const s5 Real)
(declare-const s6 Real)

; Ensure cake is fully divided
(assert (= (+ s1 s2 s3 s4 s5 s6) 1))

; Declare possible guest counts
(declare-const a1 Int)
(declare-const a2 Int)
(declare-const a3 Int)

; Assign example values for guests (replace with actual values)
(assert (= a1 3))  ; First possible guest count
(assert (= a2 4))  ; Second possible guest count
(assert (= a3 5))  ; Third possible guest count

; Ensure divisibility by each guest count
(assert (exists ((x1 Real) (x2 Real) (x3 Real))
  (and 
    (= (+ x1 x2 x3) 1)  
    (= (* a1 x1) (* a1 x2) (* a1 x3))  
  )
))

(assert (exists ((y1 Real) (y2 Real) (y3 Real) (y4 Real))
  (and 
    (= (+ y1 y2 y3 y4) 1)  
    (= (* a2 y1) (* a2 y2) (* a2 y3) (* a2 y4))  
  )
))

(assert (exists ((z1 Real) (z2 Real) (z3 Real) (z4 Real) (z5 Real))
  (and 
    (= (+ z1 z2 z3 z4 z5) 1)  
    (= (* a3 z1) (* a3 z2) (* a3 z3) (* a3 z4) (* a3 z5))  
  )
))

; Check satisfiability
(check-sat)
(get-model)
