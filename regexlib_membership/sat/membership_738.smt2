;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d{0,1}[0-9](\.\d{0,1}[0-9])?)|(100))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "89"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "9" "")))
;witness2: "8"
(define-fun Witness2 () String (seq.++ "8" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "0" "9") (re.opt (re.++ (re.range "." ".")(re.++ (re.opt (re.range "0" "9")) (re.range "0" "9")))))) (str.to_re (seq.++ "1" (seq.++ "0" (seq.++ "0" ""))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
