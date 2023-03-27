;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0|[-]{1}([1-9]{1}[0-9]{0,1}|[1]{1}([0-1]{1}[0-9]{1}|[2]{1}[0-8]{1}))|(\+)?([1-9]{1}[0-9]{0,1}|[1]{1}([0-1]{1}[0-9]{1}|[2]{1}[0-7]{1})))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0"
(define-fun Witness1 () String (str.++ "0" ""))
;witness2: "-128"
(define-fun Witness2 () String (str.++ "-" (str.++ "1" (str.++ "2" (str.++ "8" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "0")(re.union (re.++ (re.range "-" "-") (re.union (re.++ (re.range "1" "9") (re.opt (re.range "0" "9"))) (re.++ (re.range "1" "1") (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8")))))) (re.++ (re.opt (re.range "+" "+")) (re.union (re.++ (re.range "1" "9") (re.opt (re.range "0" "9"))) (re.++ (re.range "1" "1") (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "7")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
