;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(189) 868-9898"
(define-fun Witness1 () String (str.++ "(" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ ")" (str.++ " " (str.++ "8" (str.++ "6" (str.++ "8" (str.++ "-" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "8" "")))))))))))))))
;witness2: "(474) 441-2895"
(define-fun Witness2 () String (str.++ "(" (str.++ "4" (str.++ "7" (str.++ "4" (str.++ ")" (str.++ " " (str.++ "4" (str.++ "4" (str.++ "1" (str.++ "-" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "5" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (str.to_re (str.++ ")" (str.++ " " "")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
