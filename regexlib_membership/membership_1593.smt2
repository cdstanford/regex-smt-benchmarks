;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<LastName>[A-Z]\w+\-?[A-Z]?\w*),\s(?<Suffix>Jr\.|Sr\.|IV|III|II)?,?\s?(?<FirstName>[A-Z]\w*\-?[A-Z]?\w*\.?)\s?(?<MiddleName>[A-Z]?\w*\.?)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Ay,\u0085IIIZ\u00BA-VD\u00B5\u00B59\u00C6\u00F6.P"
(define-fun Witness1 () String (str.++ "A" (str.++ "y" (str.++ "," (str.++ "\u{85}" (str.++ "I" (str.++ "I" (str.++ "I" (str.++ "Z" (str.++ "\u{ba}" (str.++ "-" (str.++ "V" (str.++ "D" (str.++ "\u{b5}" (str.++ "\u{b5}" (str.++ "9" (str.++ "\u{c6}" (str.++ "\u{f6}" (str.++ "." (str.++ "P" ""))))))))))))))))))))
;witness2: "Xj\u00EE\u00C6D, IV,\xCA.\xB\u00B58."
(define-fun Witness2 () String (str.++ "X" (str.++ "j" (str.++ "\u{ee}" (str.++ "\u{c6}" (str.++ "D" (str.++ "," (str.++ " " (str.++ "I" (str.++ "V" (str.++ "," (str.++ "\u{0c}" (str.++ "A" (str.++ "." (str.++ "\u{0b}" (str.++ "\u{b5}" (str.++ "8" (str.++ "." ""))))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "A" "Z")) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))(re.++ (re.range "," ",")(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.opt (re.union (str.to_re (str.++ "J" (str.++ "r" (str.++ "." ""))))(re.union (str.to_re (str.++ "S" (str.++ "r" (str.++ "." ""))))(re.union (str.to_re (str.++ "I" (str.++ "V" "")))(re.union (str.to_re (str.++ "I" (str.++ "I" (str.++ "I" "")))) (str.to_re (str.++ "I" (str.++ "I" ""))))))))(re.++ (re.opt (re.range "," ","))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.++ (re.range "A" "Z")(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "A" "Z"))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.opt (re.range "." ".")))))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.++ (re.opt (re.range "A" "Z"))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.opt (re.range "." "."))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
