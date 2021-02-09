;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (a|A)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "anw"
(define-fun Witness1 () String (seq.++ "a" (seq.++ "n" (seq.++ "w" ""))))
;witness2: "a"
(define-fun Witness2 () String (seq.++ "a" ""))

(assert (= regexA (re.union (re.range "A" "A") (re.range "a" "a"))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
