

;Example. In 10 years, Alice will be twice as old as Bob is now, 
;but in 22 years, Bob will be twice as old as Alice is now. How old are Alice and Bob?

(set-logic QF_LIA)
(set-option :produce-models true)

(declare-const a Int)
(declare-const b Int)

(assert (= (+ a 10) (* 2 b)))
(assert (= (+ b 22) (* 2 a)))

(check-sat)
(get-model)
