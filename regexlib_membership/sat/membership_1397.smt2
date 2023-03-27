;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9]{2})?((\([0-9]{2})\)|[0-9]{2})?([0-9]{3}|[0-9]{4})(\-)?[0-9]{4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "19(28)188-8938"
(define-fun Witness1 () String (str.++ "1" (str.++ "9" (str.++ "(" (str.++ "2" (str.++ "8" (str.++ ")" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "3" (str.++ "8" "")))))))))))))))
;witness2: "(98)099-5638"
(define-fun Witness2 () String (str.++ "(" (str.++ "9" (str.++ "8" (str.++ ")" (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "5" (str.++ "6" (str.++ "3" (str.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt (re.union (re.++ (re.++ (re.range "(" "(") ((_ re.loop 2 2) (re.range "0" "9"))) (re.range ")" ")")) ((_ re.loop 2 2) (re.range "0" "9"))))(re.++ (re.union ((_ re.loop 3 3) (re.range "0" "9")) ((_ re.loop 4 4) (re.range "0" "9")))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
