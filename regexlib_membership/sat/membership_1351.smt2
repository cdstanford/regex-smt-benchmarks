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

;witness1: "8A8@8qR8P.5x9.bA"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "A" (seq.++ "8" (seq.++ "@" (seq.++ "8" (seq.++ "q" (seq.++ "R" (seq.++ "8" (seq.++ "P" (seq.++ "." (seq.++ "5" (seq.++ "x" (seq.++ "9" (seq.++ "." (seq.++ "b" (seq.++ "A" "")))))))))))))))))
;witness2: "5u@qx89\u00B5-\u00CD\u00AAfw\u00F9B.nIM"
(define-fun Witness2 () String (seq.++ "5" (seq.++ "u" (seq.++ "@" (seq.++ "q" (seq.++ "x" (seq.++ "8" (seq.++ "9" (seq.++ "\xb5" (seq.++ "-" (seq.++ "\xcd" (seq.++ "\xaa" (seq.++ "f" (seq.++ "w" (seq.++ "\xf9" (seq.++ "B" (seq.++ "." (seq.++ "n" (seq.++ "I" (seq.++ "M" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))) ((_ re.loop 2 9) (re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
