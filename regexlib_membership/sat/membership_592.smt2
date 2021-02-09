;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{3}-\d{6}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "952-940888\u00C1"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "5" (seq.++ "2" (seq.++ "-" (seq.++ "9" (seq.++ "4" (seq.++ "0" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "\xc1" ""))))))))))))
;witness2: "\x9715-853858+"
(define-fun Witness2 () String (seq.++ "\x09" (seq.++ "7" (seq.++ "1" (seq.++ "5" (seq.++ "-" (seq.++ "8" (seq.++ "5" (seq.++ "3" (seq.++ "8" (seq.++ "5" (seq.++ "8" (seq.++ "+" "")))))))))))))

(assert (= regexA (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 6 6) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
