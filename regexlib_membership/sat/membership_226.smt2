;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{1,3}((\.\d{1,3}){3}|(\.\d{1,3}){5})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9.281.828.268"
(define-fun Witness1 () String (str.++ "9" (str.++ "." (str.++ "2" (str.++ "8" (str.++ "1" (str.++ "." (str.++ "8" (str.++ "2" (str.++ "8" (str.++ "." (str.++ "2" (str.++ "6" (str.++ "8" ""))))))))))))))
;witness2: "98.958.0.07"
(define-fun Witness2 () String (str.++ "9" (str.++ "8" (str.++ "." (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "." (str.++ "0" (str.++ "." (str.++ "0" (str.++ "7" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.union ((_ re.loop 3 3) (re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9")))) ((_ re.loop 5 5) (re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
