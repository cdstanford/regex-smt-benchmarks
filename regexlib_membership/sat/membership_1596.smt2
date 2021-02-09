;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<FirstName>[A-Z]\.?\w*\-?[A-Z]?\w*)\s?(?<MiddleName>[A-Z]\w*|[A-Z]?\.?)\s?(?<LastName>[A-Z]\w*\-?[A-Z]?\w*)(?:,\s|)(?<Suffix>Jr\.|Sr\.|IV|III|II|)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&O9\u00CB9\u00AA.E-S"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "O" (seq.++ "9" (seq.++ "\xcb" (seq.++ "9" (seq.++ "\xaa" (seq.++ "." (seq.++ "E" (seq.++ "-" (seq.++ "S" "")))))))))))
;witness2: "\u00AAqA\u00FDB\xDY9\u00DA\u00B5T9z-\u00AA"
(define-fun Witness2 () String (seq.++ "\xaa" (seq.++ "q" (seq.++ "A" (seq.++ "\xfd" (seq.++ "B" (seq.++ "\x0d" (seq.++ "Y" (seq.++ "9" (seq.++ "\xda" (seq.++ "\xb5" (seq.++ "T" (seq.++ "9" (seq.++ "z" (seq.++ "-" (seq.++ "\xaa" ""))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.range "A" "Z")(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "A" "Z")) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (re.range "A" "Z") (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.++ (re.opt (re.range "A" "Z")) (re.opt (re.range "." "."))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.++ (re.range "A" "Z")(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "A" "Z")) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))(re.++ (re.union (re.++ (re.range "," ",") (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re "")) (re.union (str.to_re (seq.++ "J" (seq.++ "r" (seq.++ "." ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "r" (seq.++ "." ""))))(re.union (str.to_re (seq.++ "I" (seq.++ "V" "")))(re.union (str.to_re (seq.++ "I" (seq.++ "I" (seq.++ "I" ""))))(re.union (str.to_re (seq.++ "I" (seq.++ "I" ""))) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
