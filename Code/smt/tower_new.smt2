(set-logic QF_LIA)
 (set-option :produce-unsat-cores true)
; Number of towers (must be odd)
(define-fun num_towers () Int 5)

; Ensure num_towers is odd
(assert (= (mod num_towers 2) 1))

; Number of available frequencies
(define-fun num_frequencies () Int 3)

; Declare frequency variables for each tower
(declare-const f0 Int)
(declare-const f1 Int)
(declare-const f2 Int)
(declare-const f3 Int)
(declare-const f4 Int)

; Frequency domain constraints (each tower gets a frequency in {1, 2, 3})
(assert (and (<= 1 f0) (<= f0 num_frequencies)))
(assert (and (<= 1 f1) (<= f1 num_frequencies)))
(assert (and (<= 1 f2) (<= f2 num_frequencies)))
(assert (and (<= 1 f3) (<= f3 num_frequencies)))
(assert (and (<= 1 f4) (<= f4 num_frequencies)))

; Ensure increasing order of frequency assignments (f0 ≤ f1 ≤ f2 ≤ f3 ≤ f4)
(assert (<= f0 f1))
(assert (<= f1 f2))
(assert (<= f2 f3))
(assert (<= f3 f4))

; Example adjacency list (towers that interfere)
; Towers that interfere must have different frequencies
(assert (distinct f0 f1))
(assert (distinct f1 f2))
(assert (distinct f2 f3))
(assert (distinct f3 f4))
(assert (distinct f0 f4))

; Example: Some towers require a minimum separation of 2
(assert (>= (abs (- f1 f3)) 2))

; Solve
(check-sat)
;(get-model)
(get-unsat-core)
