(set-logic QF_UFLIA)  ; Uninterpreted Functions + Linear Integer Arithmetic


; Original Circuit

; Declare input and control signals
(declare-const in Int)        ; Input to the pipeline
(declare-const sel Bool)      ; Multiplexer select signal
(declare-const L1 Int)
(declare-const L2 Int)
(declare-const L3 Int)
(declare-const L4 Int)





; Define Uninterpreted Functions for Combinational Logic
(declare-fun F (Int) Int)     
(declare-fun G (Int) Int)     
(declare-fun H (Int) Int)     
(declare-fun K (Int) Int)     
(declare-fun D (Int) Int)  
(declare-fun C (Int) bool)     

; Stage 1: Compute L1

(assert (= L1 (F in)))
(assert (= L2 L1))

; Stage 2: Compute L2, L3, L4 and sel
(assert (= L3 (K (G L1))))
(assert (= L4 (H L1)))
(assert (= sel (C L2 )))
; Stage 3: Multiplexer behavior (MUX selects L3 or L4 based on sel)
(define-fun MUX_OUT () Int (ite sel L3 (D L4)))

; Final output stored in L5
(declare-const L5 Int)
(assert (= L5 MUX_OUT))

; Output L5 represents the final result of the pipeline


; Modified Circuit
(declare-const self Bool)      ; Multiplexer select signal
(declare-const sels Bool)  
(declare-const L1_P Int)
(declare-const L2_P Bool)
(declare-const L3_P Int)
(declare-const L5_P Int)


; Stage 1: Compute L1

(assert (= L1_P (F in)))
(assert (= L2_P (C L1_P)))

(assert (= self (C L1_P )))
(define-fun MUX_OUT_F () Int (ite self (G L1_P) (H L1_P)))

; Stage 2: Compute L2, L3, L4 and sel
(assert (= L3_P MUX_OUT_F))


(assert (= sels L2_P ))
(define-fun MUX_OUT_S () Int (ite sels (K L3_P) (D L3_P)))

(assert (= L5_P MUX_OUT_S))

(assert (= L5 L5_P)) 
(check-sat)
(get-model)