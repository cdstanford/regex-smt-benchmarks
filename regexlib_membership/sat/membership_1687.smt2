;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\{|\[|\().+(\}|\]|\)).+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(\u008F)\u00A5\u009B\u00F3\u00DB"
(define-fun Witness1 () String (str.++ "(" (str.++ "\u{8f}" (str.++ ")" (str.++ "\u{a5}" (str.++ "\u{9b}" (str.++ "\u{f3}" (str.++ "\u{db}" ""))))))))
;witness2: "{ )\u0093\x17"
(define-fun Witness2 () String (str.++ "{" (str.++ " " (str.++ ")" (str.++ "\u{93}" (str.++ "\u{17}" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "(" "(")(re.union (re.range "[" "[") (re.range "{" "{")))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.union (re.range ")" ")")(re.union (re.range "]" "]") (re.range "}" "}")))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
