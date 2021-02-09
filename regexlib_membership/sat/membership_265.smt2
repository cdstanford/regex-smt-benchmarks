;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]{1}-[0-9]{7}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "C-4988685"
(define-fun Witness1 () String (seq.++ "C" (seq.++ "-" (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "5" ""))))))))))
;witness2: "H-3299307"
(define-fun Witness2 () String (seq.++ "H" (seq.++ "-" (seq.++ "3" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "3" (seq.++ "0" (seq.++ "7" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z")(re.++ (re.range "-" "-")(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
