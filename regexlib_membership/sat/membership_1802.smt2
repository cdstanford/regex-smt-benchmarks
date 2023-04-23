;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-HJ-TP-Z]{1}\d{4}[A-Z]{3}|[a-z]{1}\d{4}[a-hj-tp-z]{3})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "c8719wbx"
(define-fun Witness1 () String (str.++ "c" (str.++ "8" (str.++ "7" (str.++ "1" (str.++ "9" (str.++ "w" (str.++ "b" (str.++ "x" "")))))))))
;witness2: "W9839XEJ"
(define-fun Witness2 () String (str.++ "W" (str.++ "9" (str.++ "8" (str.++ "3" (str.++ "9" (str.++ "X" (str.++ "E" (str.++ "J" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "H") (re.range "J" "Z"))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 3 3) (re.range "A" "Z")))) (re.++ (re.range "a" "z")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 3 3) (re.union (re.range "a" "h") (re.range "j" "z")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
