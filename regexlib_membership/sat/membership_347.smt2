;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:m|M|male|Male|f|F|female|Female)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "M"
(define-fun Witness1 () String (str.++ "M" ""))
;witness2: "female"
(define-fun Witness2 () String (str.++ "f" (str.++ "e" (str.++ "m" (str.++ "a" (str.++ "l" (str.++ "e" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.union (re.range "M" "M") (re.range "m" "m"))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "l" (str.++ "e" "")))))(re.union (str.to_re (str.++ "M" (str.++ "a" (str.++ "l" (str.++ "e" "")))))(re.union (re.union (re.range "F" "F") (re.range "f" "f"))(re.union (str.to_re (str.++ "f" (str.++ "e" (str.++ "m" (str.++ "a" (str.++ "l" (str.++ "e" ""))))))) (str.to_re (str.++ "F" (str.++ "e" (str.++ "m" (str.++ "a" (str.++ "l" (str.++ "e" "")))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
