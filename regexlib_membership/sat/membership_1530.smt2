;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9]{2})(00[1-9]|0[1-9][0-9]|[1-2][0-9][0-9]|3[0-5][0-9]|36[0-6])$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "78366"
(define-fun Witness1 () String (str.++ "7" (str.++ "8" (str.++ "3" (str.++ "6" (str.++ "6" ""))))))
;witness2: "25096"
(define-fun Witness2 () String (str.++ "2" (str.++ "5" (str.++ "0" (str.++ "9" (str.++ "6" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.++ (str.to_re (str.++ "0" (str.++ "0" ""))) (re.range "1" "9"))(re.union (re.++ (re.range "0" "0")(re.++ (re.range "1" "9") (re.range "0" "9")))(re.union (re.++ (re.range "1" "2")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "3" "3")(re.++ (re.range "0" "5") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "3" (str.++ "6" ""))) (re.range "0" "6")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
