;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([51|52|53|54|55]{2})([0-9]{14})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "|259978088991749"
(define-fun Witness1 () String (str.++ "|" (str.++ "2" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "1" (str.++ "7" (str.++ "4" (str.++ "9" "")))))))))))))))))
;witness2: "5|87559098863808"
(define-fun Witness2 () String (str.++ "5" (str.++ "|" (str.++ "8" (str.++ "7" (str.++ "5" (str.++ "5" (str.++ "9" (str.++ "0" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "6" (str.++ "3" (str.++ "8" (str.++ "0" (str.++ "8" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.union (re.range "1" "5") (re.range "|" "|")))(re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
