;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{2,4}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "67"
(define-fun Witness1 () String (str.++ "6" (str.++ "7" "")))
;witness2: "\u0092953"
(define-fun Witness2 () String (str.++ "\u{92}" (str.++ "9" (str.++ "5" (str.++ "3" "")))))

(assert (= regexA ((_ re.loop 2 4) (re.range "0" "9"))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
