;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =   | 
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\xE \u0091\u0082_\x6"
(define-fun Witness1 () String (seq.++ "\x0e" (seq.++ " " (seq.++ "\x91" (seq.++ "\x82" (seq.++ "_" (seq.++ "\x06" "")))))))
;witness2: " \x13\u00F4"
(define-fun Witness2 () String (seq.++ " " (seq.++ "\x13" (seq.++ "\xf4" ""))))

(assert (= regexA (re.union (str.to_re (seq.++ " " (seq.++ " " ""))) (re.range " " " "))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
