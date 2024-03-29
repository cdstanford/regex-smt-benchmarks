;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \p{Sm}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u008E]\u00B1"
(define-fun Witness1 () String (str.++ "\u{8e}" (str.++ "]" (str.++ "\u{b1}" ""))))
;witness2: "="
(define-fun Witness2 () String (str.++ "=" ""))

(assert (= regexA (re.union (re.range "+" "+")(re.union (re.range "<" ">")(re.union (re.range "|" "|")(re.union (re.range "~" "~")(re.union (re.range "\u{ac}" "\u{ac}")(re.union (re.range "\u{b1}" "\u{b1}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
