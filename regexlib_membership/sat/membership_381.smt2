;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{2}[9]{3}|[A-Z]{3}[9]{2}|[A-Z]{4}[9]{1}|[A-Z]{5})[0-9]{6}([A-Z]{1}[9]{1}|[A-Z]{2})[A-Z0,9]{3}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "IT999880489K90C9"
(define-fun Witness1 () String (str.++ "I" (str.++ "T" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "0" (str.++ "4" (str.++ "8" (str.++ "9" (str.++ "K" (str.++ "9" (str.++ "0" (str.++ "C" (str.++ "9" "")))))))))))))))))
;witness2: "QOQSP979920U9,9,"
(define-fun Witness2 () String (str.++ "Q" (str.++ "O" (str.++ "Q" (str.++ "S" (str.++ "P" (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "2" (str.++ "0" (str.++ "U" (str.++ "9" (str.++ "," (str.++ "9" (str.++ "," "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 2 2) (re.range "A" "Z")) ((_ re.loop 3 3) (re.range "9" "9")))(re.union (re.++ ((_ re.loop 3 3) (re.range "A" "Z")) ((_ re.loop 2 2) (re.range "9" "9")))(re.union (re.++ ((_ re.loop 4 4) (re.range "A" "Z")) (re.range "9" "9")) ((_ re.loop 5 5) (re.range "A" "Z")))))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.union (re.++ (re.range "A" "Z") (re.range "9" "9")) ((_ re.loop 2 2) (re.range "A" "Z")))(re.++ ((_ re.loop 3 3) (re.union (re.range "," ",")(re.union (re.range "0" "0")(re.union (re.range "9" "9") (re.range "A" "Z"))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
