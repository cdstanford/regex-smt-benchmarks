;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = date
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "date"
(define-fun Witness1 () String (str.++ "d" (str.++ "a" (str.++ "t" (str.++ "e" "")))))
;witness2: "date-0"
(define-fun Witness2 () String (str.++ "d" (str.++ "a" (str.++ "t" (str.++ "e" (str.++ "-" (str.++ "0" "")))))))

(assert (= regexA (str.to_re (str.++ "d" (str.++ "a" (str.++ "t" (str.++ "e" "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
