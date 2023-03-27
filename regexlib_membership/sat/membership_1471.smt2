;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =   |       # no pound sign after ampersand
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0084R\u0091Y  \x11\u00B5"
(define-fun Witness1 () String (str.++ "\u{84}" (str.++ "R" (str.++ "\u{91}" (str.++ "Y" (str.++ " " (str.++ " " (str.++ "\u{11}" (str.++ "\u{b5}" "")))))))))
;witness2: "  "
(define-fun Witness2 () String (str.++ " " (str.++ " " "")))

(assert (= regexA (re.union (str.to_re (str.++ " " (str.++ " " ""))) (str.to_re (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "#" (str.++ " " (str.++ "n" (str.++ "o" (str.++ " " (str.++ "p" (str.++ "o" (str.++ "u" (str.++ "n" (str.++ "d" (str.++ " " (str.++ "s" (str.++ "i" (str.++ "g" (str.++ "n" (str.++ " " (str.++ "a" (str.++ "f" (str.++ "t" (str.++ "e" (str.++ "r" (str.++ " " (str.++ "a" (str.++ "m" (str.++ "p" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ "a" (str.++ "n" (str.++ "d" ""))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
