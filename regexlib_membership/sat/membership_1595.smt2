;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<FirstName>[A-Z]\.?\w*\-?[A-Z]?\w*)\s?(?<MiddleName>[A-Z]\w+|[A-Z]?\.?)\s(?<LastName>[A-Z]?\w{0,3}[A-Z]\w+\-?[A-Z]?\w*)(?:,\s|)(?<Suffix>Jr\.|Sr\.|IV|III|II|)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "C\u00CB\u00CF-\u00DD\u00E1\u0085\u0085Z\u00CC\u00AAANQ"
(define-fun Witness1 () String (seq.++ "C" (seq.++ "\xcb" (seq.++ "\xcf" (seq.++ "-" (seq.++ "\xdd" (seq.++ "\xe1" (seq.++ "\x85" (seq.++ "\x85" (seq.++ "Z" (seq.++ "\xcc" (seq.++ "\xaa" (seq.++ "A" (seq.++ "N" (seq.++ "Q" "")))))))))))))))
;witness2: "B.\u00AAz\u00AA9-W\u00B5 RZ\u00B5\u00C99-3Jr."
(define-fun Witness2 () String (seq.++ "B" (seq.++ "." (seq.++ "\xaa" (seq.++ "z" (seq.++ "\xaa" (seq.++ "9" (seq.++ "-" (seq.++ "W" (seq.++ "\xb5" (seq.++ " " (seq.++ "R" (seq.++ "Z" (seq.++ "\xb5" (seq.++ "\xc9" (seq.++ "9" (seq.++ "-" (seq.++ "3" (seq.++ "J" (seq.++ "r" (seq.++ "." "")))))))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.range "A" "Z")(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "A" "Z")) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (re.range "A" "Z") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.++ (re.opt (re.range "A" "Z")) (re.opt (re.range "." "."))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.++ (re.opt (re.range "A" "Z"))(re.++ ((_ re.loop 0 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "A" "Z")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "A" "Z")) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))(re.++ (re.union (re.++ (re.range "," ",") (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re "")) (re.union (str.to_re (seq.++ "J" (seq.++ "r" (seq.++ "." ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "r" (seq.++ "." ""))))(re.union (str.to_re (seq.++ "I" (seq.++ "V" "")))(re.union (str.to_re (seq.++ "I" (seq.++ "I" (seq.++ "I" ""))))(re.union (str.to_re (seq.++ "I" (seq.++ "I" ""))) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
