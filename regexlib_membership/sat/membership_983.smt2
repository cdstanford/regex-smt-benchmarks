;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([1-4][0-9])|(0[1-9])|(5[0-2]))\/[1-2]\d{3}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "30/2182"
(define-fun Witness1 () String (str.++ "3" (str.++ "0" (str.++ "/" (str.++ "2" (str.++ "1" (str.++ "8" (str.++ "2" ""))))))))
;witness2: "19/2871"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "/" (str.++ "2" (str.++ "8" (str.++ "7" (str.++ "1" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "1" "4") (re.range "0" "9"))(re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "5" "5") (re.range "0" "2"))))(re.++ (re.range "/" "/")(re.++ (re.range "1" "2")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
