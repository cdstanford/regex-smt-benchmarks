;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (href=|url|import).*[\'"]([^(http:)].*css)[\'"]
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00FEhref=\'\u009Acss\'"
(define-fun Witness1 () String (str.++ "\u{fe}" (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ "'" (str.++ "\u{9a}" (str.++ "c" (str.++ "s" (str.++ "s" (str.++ "'" "")))))))))))))
;witness2: "\x6\u0083l\u00DBurl\"ucss\'\u00A2"
(define-fun Witness2 () String (str.++ "\u{06}" (str.++ "\u{83}" (str.++ "l" (str.++ "\u{db}" (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "\u{22}" (str.++ "u" (str.++ "c" (str.++ "s" (str.++ "s" (str.++ "'" (str.++ "\u{a2}" "")))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" ""))))))(re.union (str.to_re (str.++ "u" (str.++ "r" (str.++ "l" "")))) (str.to_re (str.++ "i" (str.++ "m" (str.++ "p" (str.++ "o" (str.++ "r" (str.++ "t" "")))))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'"))(re.++ (re.++ (re.union (re.range "\u{00}" "'")(re.union (re.range "*" "9")(re.union (re.range ";" "g")(re.union (re.range "i" "o")(re.union (re.range "q" "s") (re.range "u" "\u{ff}"))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re (str.++ "c" (str.++ "s" (str.++ "s" "")))))) (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
