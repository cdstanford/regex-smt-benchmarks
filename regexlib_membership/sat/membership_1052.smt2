;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]{1}[-][0-9]{7}[-][a-zA-Z]{1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "i-2910838-W"
(define-fun Witness1 () String (str.++ "i" (str.++ "-" (str.++ "2" (str.++ "9" (str.++ "1" (str.++ "0" (str.++ "8" (str.++ "3" (str.++ "8" (str.++ "-" (str.++ "W" ""))))))))))))
;witness2: "Z-8912538-f"
(define-fun Witness2 () String (str.++ "Z" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "2" (str.++ "5" (str.++ "3" (str.++ "8" (str.++ "-" (str.++ "f" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
