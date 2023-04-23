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

;witness1: "542080\u0085328884988997\u00985\"
(define-fun Witness1 () String (str.++ "5" (str.++ "4" (str.++ "2" (str.++ "0" (str.++ "8" (str.++ "0" (str.++ "\u{85}" (str.++ "3" (str.++ "2" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "\u{98}" (str.++ "5" (str.++ "\u{5c}" "")))))))))))))))))))))))
;witness2: "\u00D1Y3845\x99709\u00A03994\xC5905"
(define-fun Witness2 () String (str.++ "\u{d1}" (str.++ "Y" (str.++ "3" (str.++ "8" (str.++ "4" (str.++ "5" (str.++ "\u{09}" (str.++ "9" (str.++ "7" (str.++ "0" (str.++ "9" (str.++ "\u{a0}" (str.++ "3" (str.++ "9" (str.++ "9" (str.++ "4" (str.++ "\u{0c}" (str.++ "5" (str.++ "9" (str.++ "0" (str.++ "5" ""))))))))))))))))))))))

(assert (= regexA (re.union (re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 12 12) (re.range "0" "9")))) (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 4 4) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
