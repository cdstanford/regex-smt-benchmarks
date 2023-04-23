;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [1-9][0-9]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "97"
(define-fun Witness1 () String (str.++ "9" (str.++ "7" "")))
;witness2: "49\u0093"
(define-fun Witness2 () String (str.++ "4" (str.++ "9" (str.++ "\u{93}" ""))))

(assert (= regexA (re.++ (re.range "1" "9") (re.range "0" "9"))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
