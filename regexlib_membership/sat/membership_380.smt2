;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z0-9<]{9}[0-9]{1}[A-Z]{3}[0-9]{7}[A-Z]{1}[0-9]{7}[A-Z0-9<]{14}[0-9]{2}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "N11<2N<4<8XGX0130681E2255739<F0<XEE27X5P9789"
(define-fun Witness1 () String (str.++ "N" (str.++ "1" (str.++ "1" (str.++ "<" (str.++ "2" (str.++ "N" (str.++ "<" (str.++ "4" (str.++ "<" (str.++ "8" (str.++ "X" (str.++ "G" (str.++ "X" (str.++ "0" (str.++ "1" (str.++ "3" (str.++ "0" (str.++ "6" (str.++ "8" (str.++ "1" (str.++ "E" (str.++ "2" (str.++ "2" (str.++ "5" (str.++ "5" (str.++ "7" (str.++ "3" (str.++ "9" (str.++ "<" (str.++ "F" (str.++ "0" (str.++ "<" (str.++ "X" (str.++ "E" (str.++ "E" (str.++ "2" (str.++ "7" (str.++ "X" (str.++ "5" (str.++ "P" (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "9" "")))))))))))))))))))))))))))))))))))))))))))))
;witness2: "3W7TOW98J0XRQ3999518Z87799869J8<56Z<JQV47980"
(define-fun Witness2 () String (str.++ "3" (str.++ "W" (str.++ "7" (str.++ "T" (str.++ "O" (str.++ "W" (str.++ "9" (str.++ "8" (str.++ "J" (str.++ "0" (str.++ "X" (str.++ "R" (str.++ "Q" (str.++ "3" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "1" (str.++ "8" (str.++ "Z" (str.++ "8" (str.++ "7" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "9" (str.++ "J" (str.++ "8" (str.++ "<" (str.++ "5" (str.++ "6" (str.++ "Z" (str.++ "<" (str.++ "J" (str.++ "Q" (str.++ "V" (str.++ "4" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "0" "")))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 9 9) (re.union (re.range "0" "9")(re.union (re.range "<" "<") (re.range "A" "Z"))))(re.++ (re.range "0" "9")(re.++ ((_ re.loop 3 3) (re.range "A" "Z"))(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ (re.range "A" "Z")(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ ((_ re.loop 14 14) (re.union (re.range "0" "9")(re.union (re.range "<" "<") (re.range "A" "Z"))))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
