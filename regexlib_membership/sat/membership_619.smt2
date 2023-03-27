;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\[[abiu][^\[\]]*\])([^\[\]]+)(\[/?[abiu]\])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00B4>\xA[u]\u0093\u00EA[/b]\u00C0+\u008D"
(define-fun Witness1 () String (str.++ "\u{b4}" (str.++ ">" (str.++ "\u{0a}" (str.++ "[" (str.++ "u" (str.++ "]" (str.++ "\u{93}" (str.++ "\u{ea}" (str.++ "[" (str.++ "/" (str.++ "b" (str.++ "]" (str.++ "\u{c0}" (str.++ "+" (str.++ "\u{8d}" ""))))))))))))))))
;witness2: "[u\u00B1]2[u]\u009F"
(define-fun Witness2 () String (str.++ "[" (str.++ "u" (str.++ "\u{b1}" (str.++ "]" (str.++ "2" (str.++ "[" (str.++ "u" (str.++ "]" (str.++ "\u{9f}" ""))))))))))

(assert (= regexA (re.++ (re.++ (re.range "[" "[")(re.++ (re.union (re.range "a" "b")(re.union (re.range "i" "i") (re.range "u" "u")))(re.++ (re.* (re.union (re.range "\u{00}" "Z")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "^" "\u{ff}")))) (re.range "]" "]"))))(re.++ (re.+ (re.union (re.range "\u{00}" "Z")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "^" "\u{ff}")))) (re.++ (re.range "[" "[")(re.++ (re.opt (re.range "/" "/"))(re.++ (re.union (re.range "a" "b")(re.union (re.range "i" "i") (re.range "u" "u"))) (re.range "]" "]"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
