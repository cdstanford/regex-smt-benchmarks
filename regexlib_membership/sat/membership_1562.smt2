;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/(\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/(\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/(\d{2}))|(29\/02\/((0[48]|[2468][048]|[13579][26])|(00))))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "27/12/78"
(define-fun Witness1 () String (str.++ "2" (str.++ "7" (str.++ "/" (str.++ "1" (str.++ "2" (str.++ "/" (str.++ "7" (str.++ "8" "")))))))))
;witness2: "19/08/75"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "/" (str.++ "0" (str.++ "8" (str.++ "/" (str.++ "7" (str.++ "5" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.range "/" "/") ((_ re.loop 2 2) (re.range "0" "9"))))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" "")))))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1") (re.range "3" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/") ((_ re.loop 2 2) (re.range "0" "9"))))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8"))))(re.++ (str.to_re (str.++ "/" (str.++ "0" (str.++ "2" (str.++ "/" ""))))) ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (str.to_re (str.++ "2" (str.++ "9" (str.++ "/" (str.++ "0" (str.++ "2" (str.++ "/" ""))))))) (re.union (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))) (str.to_re (str.++ "0" (str.++ "0" "")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
