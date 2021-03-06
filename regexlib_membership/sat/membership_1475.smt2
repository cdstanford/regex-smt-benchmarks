;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{5}\-\d{3}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "05938-892"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "5" (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "-" (seq.++ "8" (seq.++ "9" (seq.++ "2" ""))))))))))
;witness2: "rA=16139-973"
(define-fun Witness2 () String (seq.++ "r" (seq.++ "A" (seq.++ "=" (seq.++ "1" (seq.++ "6" (seq.++ "1" (seq.++ "3" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "7" (seq.++ "3" "")))))))))))))

(assert (= regexA (re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 3 3) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
