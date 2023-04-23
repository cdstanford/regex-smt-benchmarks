;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[H][R][\-][0-9]{5}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "HR-88886"
(define-fun Witness1 () String (str.++ "H" (str.++ "R" (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "6" "")))))))))
;witness2: "HR-25499"
(define-fun Witness2 () String (str.++ "H" (str.++ "R" (str.++ "-" (str.++ "2" (str.++ "5" (str.++ "4" (str.++ "9" (str.++ "9" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "H" (str.++ "R" (str.++ "-" ""))))(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
