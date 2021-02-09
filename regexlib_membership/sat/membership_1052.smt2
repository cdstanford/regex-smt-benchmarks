;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]{1}[-][0-9]{7}[-][a-zA-Z]{1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "i-2910838-W"
(define-fun Witness1 () String (seq.++ "i" (seq.++ "-" (seq.++ "2" (seq.++ "9" (seq.++ "1" (seq.++ "0" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ "-" (seq.++ "W" ""))))))))))))
;witness2: "Z-8912538-f"
(define-fun Witness2 () String (seq.++ "Z" (seq.++ "-" (seq.++ "8" (seq.++ "9" (seq.++ "1" (seq.++ "2" (seq.++ "5" (seq.++ "3" (seq.++ "8" (seq.++ "-" (seq.++ "f" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
