;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0|(\+)?([1-9]{1}[0-9]{0,3})|([1-5]{1}[0-9]{1,4}|[6]{1}([0-4]{1}[0-9]{3}|[5]{1}([0-4]{1}[0-9]{2}|[5]{1}([0-2]{1}[0-9]{1}|[3]{1}[0-5]{1})))))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "65405"
(define-fun Witness1 () String (str.++ "6" (str.++ "5" (str.++ "4" (str.++ "0" (str.++ "5" ""))))))
;witness2: "433"
(define-fun Witness2 () String (str.++ "4" (str.++ "3" (str.++ "3" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "0")(re.union (re.++ (re.opt (re.range "+" "+")) (re.++ (re.range "1" "9") ((_ re.loop 0 3) (re.range "0" "9")))) (re.union (re.++ (re.range "1" "5") ((_ re.loop 1 4) (re.range "0" "9"))) (re.++ (re.range "6" "6") (re.union (re.++ (re.range "0" "4") ((_ re.loop 3 3) (re.range "0" "9"))) (re.++ (re.range "5" "5") (re.union (re.++ (re.range "0" "4") ((_ re.loop 2 2) (re.range "0" "9"))) (re.++ (re.range "5" "5") (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "5"))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
