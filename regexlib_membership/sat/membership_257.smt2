;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0-9]{5})|([0-9]{3}[ ]{0,1}[0-9]{2}))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "295 40"
(define-fun Witness1 () String (str.++ "2" (str.++ "9" (str.++ "5" (str.++ " " (str.++ "4" (str.++ "0" "")))))))
;witness2: "82949"
(define-fun Witness2 () String (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "4" (str.++ "9" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 5 5) (re.range "0" "9")) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range " " " ")) ((_ re.loop 2 2) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
