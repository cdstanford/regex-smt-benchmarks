;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9]+[0-9]*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9861"
(define-fun Witness1 () String (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "1" "")))))
;witness2: "1968"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "6" (str.++ "8" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.range "1" "9"))(re.++ (re.* (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
