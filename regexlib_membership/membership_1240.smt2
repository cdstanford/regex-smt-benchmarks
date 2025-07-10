;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d{6}[-\s]?\d{12})|(\d{4}[-\s]?\d{4}[-\s]?\d{4}[-\s]?\d{4})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0090.\u00860339\u00859774\xC9989\u00859998"
(define-fun Witness1 () String (str.++ "\u{90}" (str.++ "." (str.++ "\u{86}" (str.++ "0" (str.++ "3" (str.++ "3" (str.++ "9" (str.++ "\u{85}" (str.++ "9" (str.++ "7" (str.++ "7" (str.++ "4" (str.++ "\u{0c}" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "\u{85}" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" "")))))))))))))))))))))))
;witness2: "\u0082\x11889891990899\u00858939"
(define-fun Witness2 () String (str.++ "\u{82}" (str.++ "\u{11}" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "\u{85}" (str.++ "8" (str.++ "9" (str.++ "3" (str.++ "9" ""))))))))))))))))))))

(assert (= regexA (re.union (re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 12 12) (re.range "0" "9")))) (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 4 4) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
