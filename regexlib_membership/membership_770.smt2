;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:\[(?:[\u0000-\u005C]|[\u005E-\uFFFF]|\]\])+\])|(?:\u0022(?:[\u0000-\u0021]|[\u0023-\uFFFF]|\u0022\u0022)+\u0022)|(?:[a-zA-Z_][a-zA-Z0-9_]*)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "[]]\u00DDO]"
(define-fun Witness1 () String (str.++ "[" (str.++ "]" (str.++ "]" (str.++ "\u{dd}" (str.++ "O" (str.++ "]" "")))))))
;witness2: "[]]4]]]]Q]"
(define-fun Witness2 () String (str.++ "[" (str.++ "]" (str.++ "]" (str.++ "4" (str.++ "]" (str.++ "]" (str.++ "]" (str.++ "]" (str.++ "Q" (str.++ "]" "")))))))))))

(assert (= regexA (re.union (re.++ (re.range "[" "[")(re.++ (re.+ (re.union (re.union (re.range "\u{00}" "\u{5c}") (re.range "^" "\u{ff}")) (str.to_re (str.++ "]" (str.++ "]" ""))))) (re.range "]" "]")))(re.union (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.+ (re.union (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}")) (str.to_re (str.++ "\u{22}" (str.++ "\u{22}" ""))))) (re.range "\u{22}" "\u{22}"))) (re.++ (re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
