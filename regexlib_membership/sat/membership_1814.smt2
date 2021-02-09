;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z0-9]{8}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{12}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "afZ26W85-aZ7u-azSg-4dgV-iZA99zz8F7IR"
(define-fun Witness1 () String (seq.++ "a" (seq.++ "f" (seq.++ "Z" (seq.++ "2" (seq.++ "6" (seq.++ "W" (seq.++ "8" (seq.++ "5" (seq.++ "-" (seq.++ "a" (seq.++ "Z" (seq.++ "7" (seq.++ "u" (seq.++ "-" (seq.++ "a" (seq.++ "z" (seq.++ "S" (seq.++ "g" (seq.++ "-" (seq.++ "4" (seq.++ "d" (seq.++ "g" (seq.++ "V" (seq.++ "-" (seq.++ "i" (seq.++ "Z" (seq.++ "A" (seq.++ "9" (seq.++ "9" (seq.++ "z" (seq.++ "z" (seq.++ "8" (seq.++ "F" (seq.++ "7" (seq.++ "I" (seq.++ "R" "")))))))))))))))))))))))))))))))))))))
;witness2: "38dH84x2-98S2-4zu9-2939-8Wy98zHK288o"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "8" (seq.++ "d" (seq.++ "H" (seq.++ "8" (seq.++ "4" (seq.++ "x" (seq.++ "2" (seq.++ "-" (seq.++ "9" (seq.++ "8" (seq.++ "S" (seq.++ "2" (seq.++ "-" (seq.++ "4" (seq.++ "z" (seq.++ "u" (seq.++ "9" (seq.++ "-" (seq.++ "2" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "-" (seq.++ "8" (seq.++ "W" (seq.++ "y" (seq.++ "9" (seq.++ "8" (seq.++ "z" (seq.++ "H" (seq.++ "K" (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "o" "")))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
