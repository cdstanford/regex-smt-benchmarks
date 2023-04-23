;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\(\d{1,2}(\s\d{1,2}){1,2}\)\s(\d{1,2}(\s\d{1,2}){1,2})((-(\d{1,4})){0,1})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(01\u008599)\u008529\u00859\u00858-8"
(define-fun Witness1 () String (str.++ "(" (str.++ "0" (str.++ "1" (str.++ "\u{85}" (str.++ "9" (str.++ "9" (str.++ ")" (str.++ "\u{85}" (str.++ "2" (str.++ "9" (str.++ "\u{85}" (str.++ "9" (str.++ "\u{85}" (str.++ "8" (str.++ "-" (str.++ "8" "")))))))))))))))))
;witness2: "(97\u00851\u00853)\u00A00\u00A09 9-099"
(define-fun Witness2 () String (str.++ "(" (str.++ "9" (str.++ "7" (str.++ "\u{85}" (str.++ "1" (str.++ "\u{85}" (str.++ "3" (str.++ ")" (str.++ "\u{a0}" (str.++ "0" (str.++ "\u{a0}" (str.++ "9" (str.++ " " (str.++ "9" (str.++ "-" (str.++ "0" (str.++ "9" (str.++ "9" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "(" "(")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ ((_ re.loop 1 2) (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) ((_ re.loop 1 2) (re.range "0" "9"))))(re.++ (re.range ")" ")")(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.++ ((_ re.loop 1 2) (re.range "0" "9")) ((_ re.loop 1 2) (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) ((_ re.loop 1 2) (re.range "0" "9")))))(re.++ (re.opt (re.++ (re.range "-" "-") ((_ re.loop 1 4) (re.range "0" "9")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
