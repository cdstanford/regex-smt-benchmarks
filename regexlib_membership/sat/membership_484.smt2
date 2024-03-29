;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((19|20)[0-9]{2})-(([1-9])|(0[1-9])|(1[0-2]))-((3[0-1])|([0-2][0-9])|([0-9]))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "2088-08-4"
(define-fun Witness1 () String (str.++ "2" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "-" (str.++ "0" (str.++ "8" (str.++ "-" (str.++ "4" ""))))))))))
;witness2: "2082-04-9"
(define-fun Witness2 () String (str.++ "2" (str.++ "0" (str.++ "8" (str.++ "2" (str.++ "-" (str.++ "0" (str.++ "4" (str.++ "-" (str.++ "9" ""))))))))))

(assert (= regexA (re.++ (re.++ (re.union (str.to_re (str.++ "1" (str.++ "9" ""))) (str.to_re (str.++ "2" (str.++ "0" "")))) ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ (re.union (re.range "1" "9")(re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2"))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "3" "3") (re.range "0" "1"))(re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
