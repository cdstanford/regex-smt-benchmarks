;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\(]{1,}[^)]*[)]{1,}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(\u00E2l\xD)))"
(define-fun Witness1 () String (str.++ "(" (str.++ "\u{e2}" (str.++ "l" (str.++ "\u{0d}" (str.++ ")" (str.++ ")" (str.++ ")" ""))))))))
;witness2: "(\u00E3Z))\u00E4+"
(define-fun Witness2 () String (str.++ "(" (str.++ "\u{e3}" (str.++ "Z" (str.++ ")" (str.++ ")" (str.++ "\u{e4}" (str.++ "+" ""))))))))

(assert (= regexA (re.++ (re.+ (re.range "(" "("))(re.++ (re.* (re.union (re.range "\u{00}" "(") (re.range "*" "\u{ff}"))) (re.+ (re.range ")" ")"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
