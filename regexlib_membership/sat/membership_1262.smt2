;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0]{1}[6]{1}[-\s]*[1-9]{1}[\s]*([0-9]{1}[\s]*){7})|([0]{1}[1-9]{1}[0-9]{1}[0-9]{1}[-\s]*[1-9]{1}[\s]*([0-9]{1}[\s]*){5})|([0]{1}[1-9]{1}[0-9]{1}[-\s]*[1-9]{1}[\s]*([0-9]{1}[\s]*){6})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "f089\u00A07\xA   0\u00A0588\xD9\u00A05"
(define-fun Witness1 () String (str.++ "f" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "\u{a0}" (str.++ "7" (str.++ "\u{0a}" (str.++ " " (str.++ " " (str.++ " " (str.++ "0" (str.++ "\u{a0}" (str.++ "5" (str.++ "8" (str.++ "8" (str.++ "\u{0d}" (str.++ "9" (str.++ "\u{a0}" (str.++ "5" ""))))))))))))))))))))
;witness2: "0996\xD746\u00A078\u00859 \u00A0\xD"
(define-fun Witness2 () String (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "6" (str.++ "\u{0d}" (str.++ "7" (str.++ "4" (str.++ "6" (str.++ "\u{a0}" (str.++ "7" (str.++ "8" (str.++ "\u{85}" (str.++ "9" (str.++ " " (str.++ "\u{a0}" (str.++ "\u{0d}" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "0" (str.++ "6" "")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ (re.range "1" "9")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 7 7) (re.++ (re.range "0" "9") (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))(re.union (re.++ (re.range "0" "0")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ (re.range "1" "9")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 5 5) (re.++ (re.range "0" "9") (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))))) (re.++ (re.range "0" "0")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ (re.range "1" "9")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 6 6) (re.++ (re.range "0" "9") (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
