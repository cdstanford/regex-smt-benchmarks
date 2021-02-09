;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[9]9\d{10}|^[5]\d{10}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "57989892898\u00C8"
(define-fun Witness1 () String (seq.++ "5" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "\xc8" "")))))))))))))
;witness2: "59999838979W"
(define-fun Witness2 () String (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "W" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "9" (seq.++ "9" ""))) ((_ re.loop 10 10) (re.range "0" "9")))) (re.++ (str.to_re "")(re.++ (re.range "5" "5") ((_ re.loop 10 10) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
