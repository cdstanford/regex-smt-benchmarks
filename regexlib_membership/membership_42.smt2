;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = sdgsdf
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00EA\u00B1tfsdgsdf\u00FA"
(define-fun Witness1 () String (str.++ "\u{ea}" (str.++ "\u{b1}" (str.++ "t" (str.++ "f" (str.++ "s" (str.++ "d" (str.++ "g" (str.++ "s" (str.++ "d" (str.++ "f" (str.++ "\u{fa}" ""))))))))))))
;witness2: "sdgsdf"
(define-fun Witness2 () String (str.++ "s" (str.++ "d" (str.++ "g" (str.++ "s" (str.++ "d" (str.++ "f" "")))))))

(assert (= regexA (str.to_re (str.++ "s" (str.++ "d" (str.++ "g" (str.++ "s" (str.++ "d" (str.++ "f" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
