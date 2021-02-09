;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-z0-9]{1,11}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "K1m"
(define-fun Witness1 () String (seq.++ "K" (seq.++ "1" (seq.++ "m" ""))))
;witness2: "cs\x1E"
(define-fun Witness2 () String (seq.++ "c" (seq.++ "s" (seq.++ "\x1e" ""))))

(assert (= regexA ((_ re.loop 1 11) (re.union (re.range "0" "9") (re.range "a" "z")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
