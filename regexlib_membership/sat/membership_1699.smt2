;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = {.*}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E0\u0085{xi,\u00E3}\u00FF"
(define-fun Witness1 () String (str.++ "\u{e0}" (str.++ "\u{85}" (str.++ "{" (str.++ "x" (str.++ "i" (str.++ "," (str.++ "\u{e3}" (str.++ "}" (str.++ "\u{ff}" ""))))))))))
;witness2: "\u00A9\u0088(.{}d"
(define-fun Witness2 () String (str.++ "\u{a9}" (str.++ "\u{88}" (str.++ "(" (str.++ "." (str.++ "{" (str.++ "}" (str.++ "d" ""))))))))

(assert (= regexA (re.++ (re.range "{" "{")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.range "}" "}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
