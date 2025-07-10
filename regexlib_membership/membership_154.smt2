;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[{][A-Za-z0-9]{8}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{12}[}]$|^[A-Za-z0-9]{8}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{12}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "{819ZY186-4wq0-28v9-0b9G-9Lv8z86F448s}"
(define-fun Witness1 () String (str.++ "{" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "Z" (str.++ "Y" (str.++ "1" (str.++ "8" (str.++ "6" (str.++ "-" (str.++ "4" (str.++ "w" (str.++ "q" (str.++ "0" (str.++ "-" (str.++ "2" (str.++ "8" (str.++ "v" (str.++ "9" (str.++ "-" (str.++ "0" (str.++ "b" (str.++ "9" (str.++ "G" (str.++ "-" (str.++ "9" (str.++ "L" (str.++ "v" (str.++ "8" (str.++ "z" (str.++ "8" (str.++ "6" (str.++ "F" (str.++ "4" (str.++ "4" (str.++ "8" (str.++ "s" (str.++ "}" "")))))))))))))))))))))))))))))))))))))))
;witness2: "{ZL5825qa-7krB-9822-AP88-e88V6nmncX45}"
(define-fun Witness2 () String (str.++ "{" (str.++ "Z" (str.++ "L" (str.++ "5" (str.++ "8" (str.++ "2" (str.++ "5" (str.++ "q" (str.++ "a" (str.++ "-" (str.++ "7" (str.++ "k" (str.++ "r" (str.++ "B" (str.++ "-" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "2" (str.++ "-" (str.++ "A" (str.++ "P" (str.++ "8" (str.++ "8" (str.++ "-" (str.++ "e" (str.++ "8" (str.++ "8" (str.++ "V" (str.++ "6" (str.++ "n" (str.++ "m" (str.++ "n" (str.++ "c" (str.++ "X" (str.++ "4" (str.++ "5" (str.++ "}" "")))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "{" "{")(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "}" "}") (str.to_re ""))))))))))))) (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
