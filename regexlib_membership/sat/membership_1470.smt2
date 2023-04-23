;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =        |10[0-3]\d{4}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "e       \u00B1y"
(define-fun Witness1 () String (str.++ "e" (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "\u{b1}" (str.++ "y" "")))))))))))
;witness2: "\u0086A       \u00FF+\u00B7$\u00A0\u00B9"
(define-fun Witness2 () String (str.++ "\u{86}" (str.++ "A" (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "\u{ff}" (str.++ "+" (str.++ "\u{b7}" (str.++ "$" (str.++ "\u{a0}" (str.++ "\u{b9}" ""))))))))))))))))

(assert (= regexA (re.union (str.to_re (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " "")))))))) (re.++ (str.to_re (str.++ "1" (str.++ "0" "")))(re.++ (re.range "0" "3") ((_ re.loop 4 4) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
