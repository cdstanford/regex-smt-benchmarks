;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = date
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "date"
(define-fun Witness1 () String (seq.++ "d" (seq.++ "a" (seq.++ "t" (seq.++ "e" "")))))
;witness2: "date-0"
(define-fun Witness2 () String (seq.++ "d" (seq.++ "a" (seq.++ "t" (seq.++ "e" (seq.++ "-" (seq.++ "0" "")))))))

(assert (= regexA (str.to_re (seq.++ "d" (seq.++ "a" (seq.++ "t" (seq.++ "e" "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
