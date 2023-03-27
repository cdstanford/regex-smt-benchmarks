;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = df
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "df"
(define-fun Witness1 () String (str.++ "d" (str.++ "f" "")))
;witness2: "L\u0083f\u00C7df`"
(define-fun Witness2 () String (str.++ "L" (str.++ "\u{83}" (str.++ "f" (str.++ "\u{c7}" (str.++ "d" (str.++ "f" (str.++ "`" ""))))))))

(assert (= regexA (str.to_re (str.++ "d" (str.++ "f" "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
