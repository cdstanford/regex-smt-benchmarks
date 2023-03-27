;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z]+[0-9]*[a-z]+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "kkxzxa"
(define-fun Witness1 () String (str.++ "k" (str.++ "k" (str.++ "x" (str.++ "z" (str.++ "x" (str.++ "a" "")))))))
;witness2: "rgy"
(define-fun Witness2 () String (str.++ "r" (str.++ "g" (str.++ "y" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "a" "z")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
