;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{1,2}\.\d{3}\.\d{3}[-][0-9kK]{1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "8.891.257-k"
(define-fun Witness1 () String (str.++ "8" (str.++ "." (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "." (str.++ "2" (str.++ "5" (str.++ "7" (str.++ "-" (str.++ "k" ""))))))))))))
;witness2: "88.808.189-K"
(define-fun Witness2 () String (str.++ "8" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "." (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "-" (str.++ "K" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.union (re.range "0" "9")(re.union (re.range "K" "K") (re.range "k" "k"))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
