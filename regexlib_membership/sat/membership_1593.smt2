;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<LastName>[A-Z]\w+\-?[A-Z]?\w*),\s(?<Suffix>Jr\.|Sr\.|IV|III|II)?,?\s?(?<FirstName>[A-Z]\w*\-?[A-Z]?\w*\.?)\s?(?<MiddleName>[A-Z]?\w*\.?)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Ay,\u0085IIIZ\u00BA-VD\u00B5\u00B59\u00C6\u00F6.P"
(define-fun Witness1 () String (seq.++ "A" (seq.++ "y" (seq.++ "," (seq.++ "\x85" (seq.++ "I" (seq.++ "I" (seq.++ "I" (seq.++ "Z" (seq.++ "\xba" (seq.++ "-" (seq.++ "V" (seq.++ "D" (seq.++ "\xb5" (seq.++ "\xb5" (seq.++ "9" (seq.++ "\xc6" (seq.++ "\xf6" (seq.++ "." (seq.++ "P" ""))))))))))))))))))))
;witness2: "Xj\u00EE\u00C6D, IV,\xCA.\xB\u00B58."
(define-fun Witness2 () String (seq.++ "X" (seq.++ "j" (seq.++ "\xee" (seq.++ "\xc6" (seq.++ "D" (seq.++ "," (seq.++ " " (seq.++ "I" (seq.++ "V" (seq.++ "," (seq.++ "\x0c" (seq.++ "A" (seq.++ "." (seq.++ "\x0b" (seq.++ "\xb5" (seq.++ "8" (seq.++ "." ""))))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "A" "Z")) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))(re.++ (re.range "," ",")(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.opt (re.union (str.to_re (seq.++ "J" (seq.++ "r" (seq.++ "." ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "r" (seq.++ "." ""))))(re.union (str.to_re (seq.++ "I" (seq.++ "V" "")))(re.union (str.to_re (seq.++ "I" (seq.++ "I" (seq.++ "I" "")))) (str.to_re (seq.++ "I" (seq.++ "I" ""))))))))(re.++ (re.opt (re.range "," ","))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.++ (re.range "A" "Z")(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "A" "Z"))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.opt (re.range "." ".")))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.++ (re.opt (re.range "A" "Z"))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.opt (re.range "." "."))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
