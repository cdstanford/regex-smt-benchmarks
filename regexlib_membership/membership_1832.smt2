;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((((([13578])|(1[0-2]))[\-\/\s]?(([1-9])|([1-2][0-9])|(3[01])))|((([469])|(11))[\-\/\s]?(([1-9])|([1-2][0-9])|(30)))|(2[\-\/\s]?(([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s((([1-9])|(1[02]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4\u00A089608 1:57\u0085Ma"
(define-fun Witness1 () String (str.++ "4" (str.++ "\u{a0}" (str.++ "8" (str.++ "9" (str.++ "6" (str.++ "0" (str.++ "8" (str.++ " " (str.++ "1" (str.++ ":" (str.++ "5" (str.++ "7" (str.++ "\u{85}" (str.++ "M" (str.++ "a" ""))))))))))))))))
;witness2: "8\u00A01\x94185\xC8:29:49\u00A0aA"
(define-fun Witness2 () String (str.++ "8" (str.++ "\u{a0}" (str.++ "1" (str.++ "\u{09}" (str.++ "4" (str.++ "1" (str.++ "8" (str.++ "5" (str.++ "\u{0c}" (str.++ "8" (str.++ ":" (str.++ "2" (str.++ "9" (str.++ ":" (str.++ "4" (str.++ "9" (str.++ "\u{a0}" (str.++ "a" (str.++ "A" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.union (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8")))) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) (re.union (re.range "1" "9")(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))))(re.union (re.++ (re.union (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9"))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) (re.union (re.range "1" "9")(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" ""))))))) (re.++ (re.range "2" "2")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) (re.union (re.range "1" "9") (re.++ (re.range "1" "2") (re.range "0" "9")))))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) ((_ re.loop 4 4) (re.range "0" "9"))))(re.++ (re.opt (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.++ (re.union (re.range "1" "9") (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.union (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9")) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) ((_ re.loop 2 2) (re.union (re.range "A" "A")(re.union (re.range "M" "M")(re.union (re.range "P" "P")(re.union (re.range "a" "a")(re.union (re.range "m" "m")(re.union (re.range "p" "p") (re.range "|" "|")))))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
