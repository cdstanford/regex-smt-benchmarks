;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{3}-\d{7}[0-6]{1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "008-39981883"
(define-fun Witness1 () String (str.++ "0" (str.++ "0" (str.++ "8" (str.++ "-" (str.++ "3" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "3" "")))))))))))))
;witness2: "233-97982095"
(define-fun Witness2 () String (str.++ "2" (str.++ "3" (str.++ "3" (str.++ "-" (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "0" (str.++ "9" (str.++ "5" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ (re.range "0" "6") (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
