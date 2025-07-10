;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = jhkjhk
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Vjhkjhk"
(define-fun Witness1 () String (str.++ "V" (str.++ "j" (str.++ "h" (str.++ "k" (str.++ "j" (str.++ "h" (str.++ "k" ""))))))))
;witness2: "\u00F8\u00EBjhkjhkl"
(define-fun Witness2 () String (str.++ "\u{f8}" (str.++ "\u{eb}" (str.++ "j" (str.++ "h" (str.++ "k" (str.++ "j" (str.++ "h" (str.++ "k" (str.++ "l" ""))))))))))

(assert (= regexA (str.to_re (str.++ "j" (str.++ "h" (str.++ "k" (str.++ "j" (str.++ "h" (str.++ "k" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
