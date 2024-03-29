;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [cC]{1}[0-9]{0,7}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ".u\x6C"
(define-fun Witness1 () String (str.++ "." (str.++ "u" (str.++ "\u{06}" (str.++ "C" "")))))
;witness2: "\x12\x12C3"
(define-fun Witness2 () String (str.++ "\u{12}" (str.++ "\u{12}" (str.++ "C" (str.++ "3" "")))))

(assert (= regexA (re.++ (re.union (re.range "C" "C") (re.range "c" "c")) ((_ re.loop 0 7) (re.range "0" "9")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
