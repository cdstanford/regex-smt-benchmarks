;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^0[87][23467]((\d{7})|( |-)((\d{3}))( |-)(\d{4})|( |-)(\d{7})))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "072-856 1735"
(define-fun Witness1 () String (str.++ "0" (str.++ "7" (str.++ "2" (str.++ "-" (str.++ "8" (str.++ "5" (str.++ "6" (str.++ " " (str.++ "1" (str.++ "7" (str.++ "3" (str.++ "5" "")))))))))))))
;witness2: "0723383236\\u00C2\u009D"
(define-fun Witness2 () String (str.++ "0" (str.++ "7" (str.++ "2" (str.++ "3" (str.++ "3" (str.++ "8" (str.++ "3" (str.++ "2" (str.++ "3" (str.++ "6" (str.++ "\u{5c}" (str.++ "\u{c2}" (str.++ "\u{9d}" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "0")(re.++ (re.range "7" "8")(re.++ (re.union (re.range "2" "4") (re.range "6" "7")) (re.union ((_ re.loop 7 7) (re.range "0" "9"))(re.union (re.++ (re.union (re.range " " " ") (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range " " " ") (re.range "-" "-")) ((_ re.loop 4 4) (re.range "0" "9"))))) (re.++ (re.union (re.range " " " ") (re.range "-" "-")) ((_ re.loop 7 7) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
