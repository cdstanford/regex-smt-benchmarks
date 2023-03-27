;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-9A-Za-z]
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "I&\u00BF0"
(define-fun Witness1 () String (str.++ "I" (str.++ "&" (str.++ "\u{bf}" (str.++ "0" "")))))
;witness2: "u0\u00A0"
(define-fun Witness2 () String (str.++ "u" (str.++ "0" (str.++ "\u{a0}" ""))))

(assert (= regexA (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
