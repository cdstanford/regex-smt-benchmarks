;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = >(?:(?<t>[^<]*))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E8\u00A1\u0081>\u00C1+\u009B"
(define-fun Witness1 () String (seq.++ "\xe8" (seq.++ "\xa1" (seq.++ "\x81" (seq.++ ">" (seq.++ "\xc1" (seq.++ "+" (seq.++ "\x9b" ""))))))))
;witness2: ">"
(define-fun Witness2 () String (seq.++ ">" ""))

(assert (= regexA (re.++ (re.range ">" ">") (re.* (re.union (re.range "\x00" ";") (re.range "=" "\xff"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
