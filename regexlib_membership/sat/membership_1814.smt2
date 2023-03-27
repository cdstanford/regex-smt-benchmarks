;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z0-9]{8}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{12}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "afZ26W85-aZ7u-azSg-4dgV-iZA99zz8F7IR"
(define-fun Witness1 () String (str.++ "a" (str.++ "f" (str.++ "Z" (str.++ "2" (str.++ "6" (str.++ "W" (str.++ "8" (str.++ "5" (str.++ "-" (str.++ "a" (str.++ "Z" (str.++ "7" (str.++ "u" (str.++ "-" (str.++ "a" (str.++ "z" (str.++ "S" (str.++ "g" (str.++ "-" (str.++ "4" (str.++ "d" (str.++ "g" (str.++ "V" (str.++ "-" (str.++ "i" (str.++ "Z" (str.++ "A" (str.++ "9" (str.++ "9" (str.++ "z" (str.++ "z" (str.++ "8" (str.++ "F" (str.++ "7" (str.++ "I" (str.++ "R" "")))))))))))))))))))))))))))))))))))))
;witness2: "38dH84x2-98S2-4zu9-2939-8Wy98zHK288o"
(define-fun Witness2 () String (str.++ "3" (str.++ "8" (str.++ "d" (str.++ "H" (str.++ "8" (str.++ "4" (str.++ "x" (str.++ "2" (str.++ "-" (str.++ "9" (str.++ "8" (str.++ "S" (str.++ "2" (str.++ "-" (str.++ "4" (str.++ "z" (str.++ "u" (str.++ "9" (str.++ "-" (str.++ "2" (str.++ "9" (str.++ "3" (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "W" (str.++ "y" (str.++ "9" (str.++ "8" (str.++ "z" (str.++ "H" (str.++ "K" (str.++ "2" (str.++ "8" (str.++ "8" (str.++ "o" "")))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
