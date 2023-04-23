;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\$(([0-9]?)[a-zA-Z]+)([0-9]?))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xF\u00C4$3wH"
(define-fun Witness1 () String (str.++ "\u{0f}" (str.++ "\u{c4}" (str.++ "$" (str.++ "3" (str.++ "w" (str.++ "H" "")))))))
;witness2: "\u0089$9mByf9F"
(define-fun Witness2 () String (str.++ "\u{89}" (str.++ "$" (str.++ "9" (str.++ "m" (str.++ "B" (str.++ "y" (str.++ "f" (str.++ "9" (str.++ "F" ""))))))))))

(assert (= regexA (re.++ (re.range "$" "$")(re.++ (re.++ (re.opt (re.range "0" "9")) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.opt (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
