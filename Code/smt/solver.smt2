;Example. Let be a unary function from to U -> U 
;, for some set U . Check that, whatever the meaning of f , 
;if f ( f ( f (x))) = x and f (f (f ( f ( f (x))))) = x then f(x) =  x
;if and , then .


; You can edit this code!
; Click here and start typing.
(set-logic QF_UF)
(declare-sort U)

(declare-fun f (U) U)
(declare-const x U) 

(assert (and (= (f (f (f x))) x) (= (f (f (f (f (f x))))) x)))
(assert (= (f x) x))

(check-sat)





