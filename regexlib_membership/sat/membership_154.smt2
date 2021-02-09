;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[{][A-Za-z0-9]{8}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{12}[}]$|^[A-Za-z0-9]{8}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{12}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "{819ZY186-4wq0-28v9-0b9G-9Lv8z86F448s}"
(define-fun Witness1 () String (seq.++ "{" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "Z" (seq.++ "Y" (seq.++ "1" (seq.++ "8" (seq.++ "6" (seq.++ "-" (seq.++ "4" (seq.++ "w" (seq.++ "q" (seq.++ "0" (seq.++ "-" (seq.++ "2" (seq.++ "8" (seq.++ "v" (seq.++ "9" (seq.++ "-" (seq.++ "0" (seq.++ "b" (seq.++ "9" (seq.++ "G" (seq.++ "-" (seq.++ "9" (seq.++ "L" (seq.++ "v" (seq.++ "8" (seq.++ "z" (seq.++ "8" (seq.++ "6" (seq.++ "F" (seq.++ "4" (seq.++ "4" (seq.++ "8" (seq.++ "s" (seq.++ "}" "")))))))))))))))))))))))))))))))))))))))
;witness2: "{ZL5825qa-7krB-9822-AP88-e88V6nmncX45}"
(define-fun Witness2 () String (seq.++ "{" (seq.++ "Z" (seq.++ "L" (seq.++ "5" (seq.++ "8" (seq.++ "2" (seq.++ "5" (seq.++ "q" (seq.++ "a" (seq.++ "-" (seq.++ "7" (seq.++ "k" (seq.++ "r" (seq.++ "B" (seq.++ "-" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "2" (seq.++ "-" (seq.++ "A" (seq.++ "P" (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ "e" (seq.++ "8" (seq.++ "8" (seq.++ "V" (seq.++ "6" (seq.++ "n" (seq.++ "m" (seq.++ "n" (seq.++ "c" (seq.++ "X" (seq.++ "4" (seq.++ "5" (seq.++ "}" "")))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "{" "{")(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "}" "}") (str.to_re ""))))))))))))) (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
