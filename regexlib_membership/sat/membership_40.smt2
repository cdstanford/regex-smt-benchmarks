;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\+){1}91){1}[1-9]{1}[0-9]{9}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+918484979328"
(define-fun Witness1 () String (str.++ "+" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "4" (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "3" (str.++ "2" (str.++ "8" ""))))))))))))))
;witness2: "+914189412588"
(define-fun Witness2 () String (str.++ "+" (str.++ "9" (str.++ "1" (str.++ "4" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "1" (str.++ "2" (str.++ "5" (str.++ "8" (str.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "+" "+") (str.to_re (str.++ "9" (str.++ "1" ""))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
