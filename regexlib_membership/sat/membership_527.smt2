;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9])+\\{1}([a-zA-Z0-9])+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "58\4939I"
(define-fun Witness1 () String (seq.++ "5" (seq.++ "8" (seq.++ "\x5c" (seq.++ "4" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "I" "")))))))))
;witness2: "Q\88"
(define-fun Witness2 () String (seq.++ "Q" (seq.++ "\x5c" (seq.++ "8" (seq.++ "8" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "\x5c" "\x5c")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
