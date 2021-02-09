;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(a-z|A-Z|0-9)*[^#$%^&*()']*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "A-Z0-9"
(define-fun Witness1 () String (seq.++ "A" (seq.++ "-" (seq.++ "Z" (seq.++ "0" (seq.++ "-" (seq.++ "9" "")))))))
;witness2: "0-9a-za-zA-Za-z0-9A-ZA-ZA-Z0-9a-zA-ZA-Za-za-z"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "-" (seq.++ "9" (seq.++ "a" (seq.++ "-" (seq.++ "z" (seq.++ "a" (seq.++ "-" (seq.++ "z" (seq.++ "A" (seq.++ "-" (seq.++ "Z" (seq.++ "a" (seq.++ "-" (seq.++ "z" (seq.++ "0" (seq.++ "-" (seq.++ "9" (seq.++ "A" (seq.++ "-" (seq.++ "Z" (seq.++ "A" (seq.++ "-" (seq.++ "Z" (seq.++ "A" (seq.++ "-" (seq.++ "Z" (seq.++ "0" (seq.++ "-" (seq.++ "9" (seq.++ "a" (seq.++ "-" (seq.++ "z" (seq.++ "A" (seq.++ "-" (seq.++ "Z" (seq.++ "A" (seq.++ "-" (seq.++ "Z" (seq.++ "a" (seq.++ "-" (seq.++ "z" (seq.++ "a" (seq.++ "-" (seq.++ "z" ""))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (str.to_re (seq.++ "a" (seq.++ "-" (seq.++ "z" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "-" (seq.++ "Z" "")))) (str.to_re (seq.++ "0" (seq.++ "-" (seq.++ "9" "")))))))(re.++ (re.* (re.union (re.range "\x00" "\x22")(re.union (re.range "+" "]") (re.range "_" "\xff")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
