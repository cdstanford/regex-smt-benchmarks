;---
; using 8-bit bit-vectors as characters
; check if regexA is not a subset of regexB
; regexA = ^(\w|\-)+@((\w|\-)+\.)+(\w|\-)+\z
; regexB = ^((([A-Z]|[a-z]|[0-9]|\-|\.)+)@(([A-Z]|[a-z]|[0-9]|\-|\.)+)\.(([A-Z]|[a-z]){2,5}){1,25})+(((([A-Z]|[a-z]|[0-9]|\-|\.)+)@(([A-Z]|[a-z]|[0-9]|\-|\.)+)\.(([A-Z]|[a-z]){2,5}){1,25})+)*\z
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const regexB (RegEx String))
(declare-const x String)

;witness: "5@-.\u00CD"
(define-fun Witness () String (seq.++ "5" (seq.++ "@" (seq.++ "-" (seq.++ "." (seq.++ "\xcd" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.range "." ".")))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (str.to_re ""))))))))

(assert (= regexB (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".") ((_ re.loop 1 25) ((_ re.loop 2 5) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.* (re.+ (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".") ((_ re.loop 1 25) ((_ re.loop 2 5) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))) (str.to_re ""))))))

;(assert (not (re-subset regexA regexB)))
;check that the difference is nonempty, contains some x
(assert (str.in_re x regexA))
(assert (not (str.in_re x regexB)))
;check also the concrete witness
(assert (str.in_re Witness regexA))
(assert (not (str.in_re Witness regexB)))
(check-sat)
