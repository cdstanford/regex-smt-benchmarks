;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Za-z]\d[A-Za-z][-]?\d[A-Za-z]\d)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "L8V9f8"
(define-fun Witness1 () String (seq.++ "L" (seq.++ "8" (seq.++ "V" (seq.++ "9" (seq.++ "f" (seq.++ "8" "")))))))
;witness2: "g0B7C8"
(define-fun Witness2 () String (seq.++ "g" (seq.++ "0" (seq.++ "B" (seq.++ "7" (seq.++ "C" (seq.++ "8" "")))))))

(assert (= regexA (re.++ (str.to_re "") (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
