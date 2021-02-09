;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =   |       # no pound sign after ampersand
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0084R\u0091Y  \x11\u00B5"
(define-fun Witness1 () String (seq.++ "\x84" (seq.++ "R" (seq.++ "\x91" (seq.++ "Y" (seq.++ " " (seq.++ " " (seq.++ "\x11" (seq.++ "\xb5" "")))))))))
;witness2: "  "
(define-fun Witness2 () String (seq.++ " " (seq.++ " " "")))

(assert (= regexA (re.union (str.to_re (seq.++ " " (seq.++ " " ""))) (str.to_re (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "#" (seq.++ " " (seq.++ "n" (seq.++ "o" (seq.++ " " (seq.++ "p" (seq.++ "o" (seq.++ "u" (seq.++ "n" (seq.++ "d" (seq.++ " " (seq.++ "s" (seq.++ "i" (seq.++ "g" (seq.++ "n" (seq.++ " " (seq.++ "a" (seq.++ "f" (seq.++ "t" (seq.++ "e" (seq.++ "r" (seq.++ " " (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ "e" (seq.++ "r" (seq.++ "s" (seq.++ "a" (seq.++ "n" (seq.++ "d" ""))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
