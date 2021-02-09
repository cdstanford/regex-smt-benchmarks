;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =        |10[0-3]\d{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "e       \u00B1y"
(define-fun Witness1 () String (seq.++ "e" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "\xb1" (seq.++ "y" "")))))))))))
;witness2: "\u0086A       \u00FF+\u00B7$\u00A0\u00B9"
(define-fun Witness2 () String (seq.++ "\x86" (seq.++ "A" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "\xff" (seq.++ "+" (seq.++ "\xb7" (seq.++ "$" (seq.++ "\xa0" (seq.++ "\xb9" ""))))))))))))))))

(assert (= regexA (re.union (str.to_re (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " "")))))))) (re.++ (str.to_re (seq.++ "1" (seq.++ "0" "")))(re.++ (re.range "0" "3") ((_ re.loop 4 4) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
