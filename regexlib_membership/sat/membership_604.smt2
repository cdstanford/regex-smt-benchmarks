;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Z"
(define-fun Witness1 () String (seq.++ "Z" ""))
;witness2: "Z"
(define-fun Witness2 () String (seq.++ "Z" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z") (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
