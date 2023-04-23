;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((5[1-5])([0-9]{2})((-|\s)?[0-9]{4}){3})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "5165 97893549\u00A02583"
(define-fun Witness1 () String (str.++ "5" (str.++ "1" (str.++ "6" (str.++ "5" (str.++ " " (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "9" (str.++ "3" (str.++ "5" (str.++ "4" (str.++ "9" (str.++ "\u{a0}" (str.++ "2" (str.++ "5" (str.++ "8" (str.++ "3" "")))))))))))))))))))
;witness2: "54986898\x99955\u00A08899"
(define-fun Witness2 () String (str.++ "5" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "\u{09}" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "5" (str.++ "\u{a0}" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.++ (re.range "5" "5") (re.range "1" "5"))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) ((_ re.loop 3 3) (re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 4 4) (re.range "0" "9")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
