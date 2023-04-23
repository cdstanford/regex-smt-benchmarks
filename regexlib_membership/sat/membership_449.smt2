;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([1-9]|0[1-9]|[12][0-9]|3[01])(-|/)(([1-9]|0[1-9])|(1[0-2]))(-|/)(([0-9][0-9])|([0-9][0-9][0-9][0-9]))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "07/4-7829"
(define-fun Witness1 () String (str.++ "0" (str.++ "7" (str.++ "/" (str.++ "4" (str.++ "-" (str.++ "7" (str.++ "8" (str.++ "2" (str.++ "9" ""))))))))))
;witness2: "09/7-09"
(define-fun Witness2 () String (str.++ "0" (str.++ "9" (str.++ "/" (str.++ "7" (str.++ "-" (str.++ "0" (str.++ "9" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "1" "9")(re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.union (re.range "1" "9") (re.++ (re.range "0" "0") (re.range "1" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.++ (re.range "0" "9") (re.range "0" "9")) (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
