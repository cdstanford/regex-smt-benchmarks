;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<FirstName>[A-Z]\.?\w*\-?[A-Z]?\w*)\s?(?<MiddleName>[A-Z]\w+|[A-Z]?\.?)\s(?<LastName>(?:[A-Z]\w{1,3}|St\.\s)?[A-Z]\w+\-?[A-Z]?\w*)(?:,\s|)(?<Suffix>Jr\.|Sr\.|IV|III|II|)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "U.-\u00FB\xDY7\u00A0SNC"
(define-fun Witness1 () String (str.++ "U" (str.++ "." (str.++ "-" (str.++ "\u{fb}" (str.++ "\u{0d}" (str.++ "Y" (str.++ "7" (str.++ "\u{a0}" (str.++ "S" (str.++ "N" (str.++ "C" ""))))))))))))
;witness2: "}\x1EH-z\u00F8E.\xDD\u00D0-,\u0085Sr."
(define-fun Witness2 () String (str.++ "}" (str.++ "\u{1e}" (str.++ "H" (str.++ "-" (str.++ "z" (str.++ "\u{f8}" (str.++ "E" (str.++ "." (str.++ "\u{0d}" (str.++ "D" (str.++ "\u{d0}" (str.++ "-" (str.++ "," (str.++ "\u{85}" (str.++ "S" (str.++ "r" (str.++ "." ""))))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.range "A" "Z")(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "A" "Z")) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.++ (re.range "A" "Z") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.++ (re.opt (re.range "A" "Z")) (re.opt (re.range "." "."))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.++ (re.opt (re.union (re.++ (re.range "A" "Z") ((_ re.loop 1 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.++ (str.to_re (str.++ "S" (str.++ "t" (str.++ "." "")))) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ (re.range "A" "Z")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "A" "Z")) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))))(re.++ (re.union (re.++ (re.range "," ",") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")) (re.union (str.to_re (str.++ "J" (str.++ "r" (str.++ "." ""))))(re.union (str.to_re (str.++ "S" (str.++ "r" (str.++ "." ""))))(re.union (str.to_re (str.++ "I" (str.++ "V" "")))(re.union (str.to_re (str.++ "I" (str.++ "I" (str.++ "I" ""))))(re.union (str.to_re (str.++ "I" (str.++ "I" ""))) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
