;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[12345]$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "3"
(define-fun Witness1 () String (seq.++ "3" ""))
;witness2: "5"
(define-fun Witness2 () String (seq.++ "5" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "1" "5") (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
