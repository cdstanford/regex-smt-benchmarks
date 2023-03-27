;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0]{1}[6]{1}[-\s]*([1-9]{1}[\s]*){8})|([0]{1}[1-9]{1}[0-9]{1}[0-9]{1}[-\s]*([1-9]{1}[\s]*){6})|([0]{1}[1-9]{1}[0-9]{1}[-\s]*([1-9]{1}[\s]*){7})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0696  3\xA \x9\u00858 \x9\u00A0\u00A0 \x9 \xD\u00856413"
(define-fun Witness1 () String (str.++ "0" (str.++ "6" (str.++ "9" (str.++ "6" (str.++ " " (str.++ " " (str.++ "3" (str.++ "\u{0a}" (str.++ " " (str.++ "\u{09}" (str.++ "\u{85}" (str.++ "8" (str.++ " " (str.++ "\u{09}" (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ " " (str.++ "\u{09}" (str.++ " " (str.++ "\u{0d}" (str.++ "\u{85}" (str.++ "6" (str.++ "4" (str.++ "1" (str.++ "3" ""))))))))))))))))))))))))))
;witness2: "\u00C1018\xC 8\u00A09\u00A0\u00A0\x949881\u0082\u00C9n"
(define-fun Witness2 () String (str.++ "\u{c1}" (str.++ "0" (str.++ "1" (str.++ "8" (str.++ "\u{0c}" (str.++ " " (str.++ "8" (str.++ "\u{a0}" (str.++ "9" (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "\u{09}" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "1" (str.++ "\u{82}" (str.++ "\u{c9}" (str.++ "n" "")))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "0" (str.++ "6" "")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 8 8) (re.++ (re.range "1" "9") (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))(re.union (re.++ (re.range "0" "0")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 6 6) (re.++ (re.range "1" "9") (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))) (re.++ (re.range "0" "0")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 7 7) (re.++ (re.range "1" "9") (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
