;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (1 )?\d{3} \d{3}-\d{4}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "C\u008D\u00F01 699 980-7538"
(define-fun Witness1 () String (str.++ "C" (str.++ "\u{8d}" (str.++ "\u{f0}" (str.++ "1" (str.++ " " (str.++ "6" (str.++ "9" (str.++ "9" (str.++ " " (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "-" (str.++ "7" (str.++ "5" (str.++ "3" (str.++ "8" ""))))))))))))))))))
;witness2: "1 903 943-8489|"
(define-fun Witness2 () String (str.++ "1" (str.++ " " (str.++ "9" (str.++ "0" (str.++ "3" (str.++ " " (str.++ "9" (str.++ "4" (str.++ "3" (str.++ "-" (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "9" (str.++ "|" ""))))))))))))))))

(assert (= regexA (re.++ (re.opt (str.to_re (str.++ "1" (str.++ " " ""))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
