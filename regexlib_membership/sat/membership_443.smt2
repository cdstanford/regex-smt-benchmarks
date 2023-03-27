;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d{3}\-\d{2}\-\d{4})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "498-68-7836\u0081\u008E"
(define-fun Witness1 () String (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "-" (str.++ "6" (str.++ "8" (str.++ "-" (str.++ "7" (str.++ "8" (str.++ "3" (str.++ "6" (str.++ "\u{81}" (str.++ "\u{8e}" ""))))))))))))))
;witness2: "622-99-5608i"
(define-fun Witness2 () String (str.++ "6" (str.++ "2" (str.++ "2" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "5" (str.++ "6" (str.++ "0" (str.++ "8" (str.++ "i" "")))))))))))))

(assert (= regexA (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
