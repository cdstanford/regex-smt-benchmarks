;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]{1}[0-9]{1}[a-zA-Z]{1}(\-| |){1}[0-9]{1}[a-zA-Z]{1}[0-9]{1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "e1m 9u8"
(define-fun Witness1 () String (seq.++ "e" (seq.++ "1" (seq.++ "m" (seq.++ " " (seq.++ "9" (seq.++ "u" (seq.++ "8" ""))))))))
;witness2: "y9V8Q8"
(define-fun Witness2 () String (seq.++ "y" (seq.++ "9" (seq.++ "V" (seq.++ "8" (seq.++ "Q" (seq.++ "8" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.union (re.union (re.range " " " ") (re.range "-" "-")) (str.to_re ""))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "0" "9") (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
