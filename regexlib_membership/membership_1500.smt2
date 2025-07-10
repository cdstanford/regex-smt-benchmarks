;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[+][0-9]\d{2}-\d{3}-\d{4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+380-992-9284"
(define-fun Witness1 () String (str.++ "+" (str.++ "3" (str.++ "8" (str.++ "0" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "2" (str.++ "-" (str.++ "9" (str.++ "2" (str.++ "8" (str.++ "4" ""))))))))))))))
;witness2: "+188-290-8748"
(define-fun Witness2 () String (str.++ "+" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "-" (str.++ "2" (str.++ "9" (str.++ "0" (str.++ "-" (str.++ "8" (str.++ "7" (str.++ "4" (str.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "+" "+")(re.++ (re.range "0" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
