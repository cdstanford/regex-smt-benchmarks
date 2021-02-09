;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\$(([0-9]?)[a-zA-Z]+)([0-9]?))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\xF\u00C4$3wH"
(define-fun Witness1 () String (seq.++ "\x0f" (seq.++ "\xc4" (seq.++ "$" (seq.++ "3" (seq.++ "w" (seq.++ "H" "")))))))
;witness2: "\u0089$9mByf9F"
(define-fun Witness2 () String (seq.++ "\x89" (seq.++ "$" (seq.++ "9" (seq.++ "m" (seq.++ "B" (seq.++ "y" (seq.++ "f" (seq.++ "9" (seq.++ "F" ""))))))))))

(assert (= regexA (re.++ (re.range "$" "$")(re.++ (re.++ (re.opt (re.range "0" "9")) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.opt (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
