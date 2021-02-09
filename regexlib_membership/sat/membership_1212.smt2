;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\.([rR]([aA][rR]|\d{2})|(\d{3})?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "."
(define-fun Witness1 () String (seq.++ "." ""))
;witness2: "."
(define-fun Witness2 () String (seq.++ "." ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.union (re.range "R" "R") (re.range "r" "r")) (re.union (re.++ (re.union (re.range "A" "A") (re.range "a" "a")) (re.union (re.range "R" "R") (re.range "r" "r"))) ((_ re.loop 2 2) (re.range "0" "9")))) (re.opt ((_ re.loop 3 3) (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
