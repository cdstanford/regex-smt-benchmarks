;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = >(?:(?<t>[^<]*))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E8\u00A1\u0081>\u00C1+\u009B"
(define-fun Witness1 () String (str.++ "\u{e8}" (str.++ "\u{a1}" (str.++ "\u{81}" (str.++ ">" (str.++ "\u{c1}" (str.++ "+" (str.++ "\u{9b}" ""))))))))
;witness2: ">"
(define-fun Witness2 () String (str.++ ">" ""))

(assert (= regexA (re.++ (re.range ">" ">") (re.* (re.union (re.range "\u{00}" ";") (re.range "=" "\u{ff}"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
