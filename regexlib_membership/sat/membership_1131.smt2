;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (([a-zA-Z]{3}[0-9]{3})|(\w{2}-\w{2}-\w{2})|([0-9]{2}-[a-zA-Z]{3}-[0-9]{1})|([0-9]{1}-[a-zA-Z]{3}-[0-9]{2})|([a-zA-Z]{1}-[0-9]{3}-[a-zA-Z]{2}))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ",\u00B2d\u00BB|6-BGy-98"
(define-fun Witness1 () String (seq.++ "," (seq.++ "\xb2" (seq.++ "d" (seq.++ "\xbb" (seq.++ "|" (seq.++ "6" (seq.++ "-" (seq.++ "B" (seq.++ "G" (seq.++ "y" (seq.++ "-" (seq.++ "9" (seq.++ "8" ""))))))))))))))
;witness2: "\u00E2\u0095335-ykJ-80\u00DB"
(define-fun Witness2 () String (seq.++ "\xe2" (seq.++ "\x95" (seq.++ "3" (seq.++ "3" (seq.++ "5" (seq.++ "-" (seq.++ "y" (seq.++ "k" (seq.++ "J" (seq.++ "-" (seq.++ "8" (seq.++ "0" (seq.++ "\xdb" ""))))))))))))))

(assert (= regexA (re.union (re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))(re.union (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "-" "-") (re.range "0" "9")))))(re.union (re.++ (re.range "0" "9")(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9")))))) (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
