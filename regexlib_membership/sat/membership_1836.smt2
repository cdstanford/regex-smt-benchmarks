;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((((0[13578])|(1[02]))[\/]?(([0-2][0-9])|(3[01])))|(((0[469])|(11))[\/]?(([0-2][0-9])|(30)))|(02[\/]?[0-2][0-9]))[\/]?\d{4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "02/295989"
(define-fun Witness1 () String (str.++ "0" (str.++ "2" (str.++ "/" (str.++ "2" (str.++ "9" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "9" ""))))))))))
;witness2: "02088580"
(define-fun Witness2 () String (str.++ "0" (str.++ "2" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "5" (str.++ "8" (str.++ "0" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.opt (re.range "/" "/")) (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.opt (re.range "/" "/")) (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" "")))))) (re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.range "0" "2") (re.range "0" "9"))))))(re.++ (re.opt (re.range "/" "/"))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
