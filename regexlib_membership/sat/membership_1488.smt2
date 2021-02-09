;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6@y\u00D2\u00BA\u00B5Xg\u00BA\u00D8-4.13.92.Muyu"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "@" (seq.++ "y" (seq.++ "\xd2" (seq.++ "\xba" (seq.++ "\xb5" (seq.++ "X" (seq.++ "g" (seq.++ "\xba" (seq.++ "\xd8" (seq.++ "-" (seq.++ "4" (seq.++ "." (seq.++ "1" (seq.++ "3" (seq.++ "." (seq.++ "9" (seq.++ "2" (seq.++ "." (seq.++ "M" (seq.++ "u" (seq.++ "y" (seq.++ "u" ""))))))))))))))))))))))))
;witness2: "19A\u00AA9\u00B5\u00B5\u00AA\u00AA\u00E5412z@z8Z19.NC"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "9" (seq.++ "A" (seq.++ "\xaa" (seq.++ "9" (seq.++ "\xb5" (seq.++ "\xb5" (seq.++ "\xaa" (seq.++ "\xaa" (seq.++ "\xe5" (seq.++ "4" (seq.++ "1" (seq.++ "2" (seq.++ "z" (seq.++ "@" (seq.++ "z" (seq.++ "8" (seq.++ "Z" (seq.++ "1" (seq.++ "9" (seq.++ "." (seq.++ "N" (seq.++ "C" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))) ((_ re.loop 2 9) (re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
