;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z0-9<]{9}[0-9]{1}[A-Z]{3}[0-9]{7}[A-Z]{1}[0-9]{7}[A-Z0-9<]{14}[0-9]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "N11<2N<4<8XGX0130681E2255739<F0<XEE27X5P9789"
(define-fun Witness1 () String (seq.++ "N" (seq.++ "1" (seq.++ "1" (seq.++ "<" (seq.++ "2" (seq.++ "N" (seq.++ "<" (seq.++ "4" (seq.++ "<" (seq.++ "8" (seq.++ "X" (seq.++ "G" (seq.++ "X" (seq.++ "0" (seq.++ "1" (seq.++ "3" (seq.++ "0" (seq.++ "6" (seq.++ "8" (seq.++ "1" (seq.++ "E" (seq.++ "2" (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ "7" (seq.++ "3" (seq.++ "9" (seq.++ "<" (seq.++ "F" (seq.++ "0" (seq.++ "<" (seq.++ "X" (seq.++ "E" (seq.++ "E" (seq.++ "2" (seq.++ "7" (seq.++ "X" (seq.++ "5" (seq.++ "P" (seq.++ "9" (seq.++ "7" (seq.++ "8" (seq.++ "9" "")))))))))))))))))))))))))))))))))))))))))))))
;witness2: "3W7TOW98J0XRQ3999518Z87799869J8<56Z<JQV47980"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "W" (seq.++ "7" (seq.++ "T" (seq.++ "O" (seq.++ "W" (seq.++ "9" (seq.++ "8" (seq.++ "J" (seq.++ "0" (seq.++ "X" (seq.++ "R" (seq.++ "Q" (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "1" (seq.++ "8" (seq.++ "Z" (seq.++ "8" (seq.++ "7" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ "J" (seq.++ "8" (seq.++ "<" (seq.++ "5" (seq.++ "6" (seq.++ "Z" (seq.++ "<" (seq.++ "J" (seq.++ "Q" (seq.++ "V" (seq.++ "4" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "0" "")))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 9 9) (re.union (re.range "0" "9")(re.union (re.range "<" "<") (re.range "A" "Z"))))(re.++ (re.range "0" "9")(re.++ ((_ re.loop 3 3) (re.range "A" "Z"))(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ (re.range "A" "Z")(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ ((_ re.loop 14 14) (re.union (re.range "0" "9")(re.union (re.range "<" "<") (re.range "A" "Z"))))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
