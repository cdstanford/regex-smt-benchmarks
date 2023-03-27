;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^( [1-9]|[1-9]|0[1-9]|10|11|12)[0-5]\d$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "759"
(define-fun Witness1 () String (str.++ "7" (str.++ "5" (str.++ "9" ""))))
;witness2: "945"
(define-fun Witness2 () String (str.++ "9" (str.++ "4" (str.++ "5" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range " " " ") (re.range "1" "9"))(re.union (re.range "1" "9")(re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (str.to_re (str.++ "1" (str.++ "0" "")))(re.union (str.to_re (str.++ "1" (str.++ "1" ""))) (str.to_re (str.++ "1" (str.++ "2" ""))))))))(re.++ (re.range "0" "5")(re.++ (re.range "0" "9") (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
