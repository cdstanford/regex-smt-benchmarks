;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9]{4})-([0-1][0-9])-([0-3][0-9])\s([0-1][0-9]|[2][0-3]):([0-5][0-9]):([0-5][0-9])$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "7827-00-13 22:09:09"
(define-fun Witness1 () String (str.++ "7" (str.++ "8" (str.++ "2" (str.++ "7" (str.++ "-" (str.++ "0" (str.++ "0" (str.++ "-" (str.++ "1" (str.++ "3" (str.++ " " (str.++ "2" (str.++ "2" (str.++ ":" (str.++ "0" (str.++ "9" (str.++ ":" (str.++ "0" (str.++ "9" ""))))))))))))))))))))
;witness2: "1597-17-19\u008507:15:48"
(define-fun Witness2 () String (str.++ "1" (str.++ "5" (str.++ "9" (str.++ "7" (str.++ "-" (str.++ "1" (str.++ "7" (str.++ "-" (str.++ "1" (str.++ "9" (str.++ "\u{85}" (str.++ "0" (str.++ "7" (str.++ ":" (str.++ "1" (str.++ "5" (str.++ ":" (str.++ "4" (str.++ "8" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.++ (re.range "0" "1") (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.++ (re.range "0" "3") (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9")) (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
