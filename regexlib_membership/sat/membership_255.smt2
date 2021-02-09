;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-7]{3})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "165"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "6" (seq.++ "5" ""))))
;witness2: "662"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "6" (seq.++ "2" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "7")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
