;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = wwwwwwww
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00C7wwwwwwwwW\u0093#"
(define-fun Witness1 () String (str.++ "\u{c7}" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "W" (str.++ "\u{93}" (str.++ "#" "")))))))))))))
;witness2: "\u009B\u0091wwwwwwww\u00F3"
(define-fun Witness2 () String (str.++ "\u{9b}" (str.++ "\u{91}" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "\u{f3}" ""))))))))))))

(assert (= regexA (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
