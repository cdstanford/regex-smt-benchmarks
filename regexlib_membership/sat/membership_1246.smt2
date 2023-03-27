;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([34|37]{2})([0-9]{13})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "3|4896944989889"
(define-fun Witness1 () String (str.++ "3" (str.++ "|" (str.++ "4" (str.++ "8" (str.++ "9" (str.++ "6" (str.++ "9" (str.++ "4" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" ""))))))))))))))))
;witness2: "336398988988911"
(define-fun Witness2 () String (str.++ "3" (str.++ "3" (str.++ "6" (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "1" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.union (re.range "3" "4")(re.union (re.range "7" "7") (re.range "|" "|"))))(re.++ ((_ re.loop 13 13) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
