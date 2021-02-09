;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = jhkjhk
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Vjhkjhk"
(define-fun Witness1 () String (seq.++ "V" (seq.++ "j" (seq.++ "h" (seq.++ "k" (seq.++ "j" (seq.++ "h" (seq.++ "k" ""))))))))
;witness2: "\u00F8\u00EBjhkjhkl"
(define-fun Witness2 () String (seq.++ "\xf8" (seq.++ "\xeb" (seq.++ "j" (seq.++ "h" (seq.++ "k" (seq.++ "j" (seq.++ "h" (seq.++ "k" (seq.++ "l" ""))))))))))

(assert (= regexA (str.to_re (seq.++ "j" (seq.++ "h" (seq.++ "k" (seq.++ "j" (seq.++ "h" (seq.++ "k" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
