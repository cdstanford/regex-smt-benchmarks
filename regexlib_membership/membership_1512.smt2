;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]{1}[0-9]{1}[a-zA-Z]{1}(\-| |){1}[0-9]{1}[a-zA-Z]{1}[0-9]{1}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "e1m 9u8"
(define-fun Witness1 () String (str.++ "e" (str.++ "1" (str.++ "m" (str.++ " " (str.++ "9" (str.++ "u" (str.++ "8" ""))))))))
;witness2: "y9V8Q8"
(define-fun Witness2 () String (str.++ "y" (str.++ "9" (str.++ "V" (str.++ "8" (str.++ "Q" (str.++ "8" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.union (re.union (re.range " " " ") (re.range "-" "-")) (str.to_re ""))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "0" "9") (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
