;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =   | 
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xE \u0091\u0082_\x6"
(define-fun Witness1 () String (str.++ "\u{0e}" (str.++ " " (str.++ "\u{91}" (str.++ "\u{82}" (str.++ "_" (str.++ "\u{06}" "")))))))
;witness2: " \x13\u00F4"
(define-fun Witness2 () String (str.++ " " (str.++ "\u{13}" (str.++ "\u{f4}" ""))))

(assert (= regexA (re.union (str.to_re (str.++ " " (str.++ " " ""))) (re.range " " " "))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
