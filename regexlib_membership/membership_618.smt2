;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\[a url=\"[^\[\]\"]*\"\])([^\[\]]+)(\[/a\])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "[a url=\"\u00D0\u00B8\u00A0\u00C1\"]\u00BD[/a]"
(define-fun Witness1 () String (str.++ "[" (str.++ "a" (str.++ " " (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{d0}" (str.++ "\u{b8}" (str.++ "\u{a0}" (str.++ "\u{c1}" (str.++ "\u{22}" (str.++ "]" (str.++ "\u{bd}" (str.++ "[" (str.++ "/" (str.++ "a" (str.++ "]" ""))))))))))))))))))))
;witness2: "P\u00E5\u00D4[a url=\"\"]0[/a]}\u00D2"
(define-fun Witness2 () String (str.++ "P" (str.++ "\u{e5}" (str.++ "\u{d4}" (str.++ "[" (str.++ "a" (str.++ " " (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "]" (str.++ "0" (str.++ "[" (str.++ "/" (str.++ "a" (str.++ "]" (str.++ "}" (str.++ "\u{d2}" "")))))))))))))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (str.++ "[" (str.++ "a" (str.++ " " (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "=" (str.++ "\u{22}" "")))))))))(re.++ (re.* (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "Z")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "^" "\u{ff}"))))) (str.to_re (str.++ "\u{22}" (str.++ "]" "")))))(re.++ (re.+ (re.union (re.range "\u{00}" "Z")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "^" "\u{ff}")))) (str.to_re (str.++ "[" (str.++ "/" (str.++ "a" (str.++ "]" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
