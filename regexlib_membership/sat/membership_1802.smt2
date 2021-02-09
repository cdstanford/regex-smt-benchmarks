;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-HJ-TP-Z]{1}\d{4}[A-Z]{3}|[a-z]{1}\d{4}[a-hj-tp-z]{3})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "c8719wbx"
(define-fun Witness1 () String (seq.++ "c" (seq.++ "8" (seq.++ "7" (seq.++ "1" (seq.++ "9" (seq.++ "w" (seq.++ "b" (seq.++ "x" "")))))))))
;witness2: "W9839XEJ"
(define-fun Witness2 () String (seq.++ "W" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "9" (seq.++ "X" (seq.++ "E" (seq.++ "J" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "H") (re.range "J" "Z"))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 3 3) (re.range "A" "Z")))) (re.++ (re.range "a" "z")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 3 3) (re.union (re.range "a" "h") (re.range "j" "z")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
