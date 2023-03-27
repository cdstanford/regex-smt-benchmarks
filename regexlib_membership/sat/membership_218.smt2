;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]+[A-Z0-9,\x5F]*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "FIH_"
(define-fun Witness1 () String (str.++ "F" (str.++ "I" (str.++ "H" (str.++ "_" "")))))
;witness2: "S"
(define-fun Witness2 () String (str.++ "S" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.range "A" "Z"))(re.++ (re.* (re.union (re.range "," ",")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "_" "_"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
