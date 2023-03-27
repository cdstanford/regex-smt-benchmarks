;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0|(\+)?[1-9]{1}[0-9]{0,8}|(\+)?[1-3]{1}[0-9]{1,9}|(\+)?[4]{1}([0-1]{1}[0-9]{8}|[2]{1}([0-8]{1}[0-9]{7}|[9]{1}([0-3]{1}[0-9]{6}|[4]{1}([0-8]{1}[0-9]{5}|[9]{1}([0-5]{1}[0-9]{4}|[6]{1}([0-6]{1}[0-9]{3}|[7]{1}([0-1]{1}[0-9]{2}|[2]{1}([0-8]{1}[0-9]{1}|[9]{1}[0-5]{1})))))))))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0"
(define-fun Witness1 () String (str.++ "0" ""))
;witness2: "0"
(define-fun Witness2 () String (str.++ "0" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "0")(re.union (re.++ (re.opt (re.range "+" "+"))(re.++ (re.range "1" "9") ((_ re.loop 0 8) (re.range "0" "9"))))(re.union (re.++ (re.opt (re.range "+" "+"))(re.++ (re.range "1" "3") ((_ re.loop 1 9) (re.range "0" "9")))) (re.++ (re.opt (re.range "+" "+"))(re.++ (re.range "4" "4") (re.union (re.++ (re.range "0" "1") ((_ re.loop 8 8) (re.range "0" "9"))) (re.++ (re.range "2" "2") (re.union (re.++ (re.range "0" "8") ((_ re.loop 7 7) (re.range "0" "9"))) (re.++ (re.range "9" "9") (re.union (re.++ (re.range "0" "3") ((_ re.loop 6 6) (re.range "0" "9"))) (re.++ (re.range "4" "4") (re.union (re.++ (re.range "0" "8") ((_ re.loop 5 5) (re.range "0" "9"))) (re.++ (re.range "9" "9") (re.union (re.++ (re.range "0" "5") ((_ re.loop 4 4) (re.range "0" "9"))) (re.++ (re.range "6" "6") (re.union (re.++ (re.range "0" "6") ((_ re.loop 3 3) (re.range "0" "9"))) (re.++ (re.range "7" "7") (re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9"))) (re.++ (re.range "2" "2") (re.union (re.++ (re.range "0" "8") (re.range "0" "9")) (re.++ (re.range "9" "9") (re.range "0" "5")))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
