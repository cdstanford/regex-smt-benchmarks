;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}"
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0097q\"\ddd\\u00CC\d\H\d\\u0097\ddd\"A\u00B6"
(define-fun Witness1 () String (str.++ "\u{97}" (str.++ "q" (str.++ "\u{22}" (str.++ "\u{5c}" (str.++ "d" (str.++ "d" (str.++ "d" (str.++ "\u{5c}" (str.++ "\u{cc}" (str.++ "\u{5c}" (str.++ "d" (str.++ "\u{5c}" (str.++ "H" (str.++ "\u{5c}" (str.++ "d" (str.++ "\u{5c}" (str.++ "\u{97}" (str.++ "\u{5c}" (str.++ "d" (str.++ "d" (str.++ "d" (str.++ "\u{22}" (str.++ "A" (str.++ "\u{b6}" "")))))))))))))))))))))))))
;witness2: "\u00CD\u00EE\"\ddd\\u009E\ddd\\u0093\d\\x1A\dd\""
(define-fun Witness2 () String (str.++ "\u{cd}" (str.++ "\u{ee}" (str.++ "\u{22}" (str.++ "\u{5c}" (str.++ "d" (str.++ "d" (str.++ "d" (str.++ "\u{5c}" (str.++ "\u{9e}" (str.++ "\u{5c}" (str.++ "d" (str.++ "d" (str.++ "d" (str.++ "\u{5c}" (str.++ "\u{93}" (str.++ "\u{5c}" (str.++ "d" (str.++ "\u{5c}" (str.++ "\u{1a}" (str.++ "\u{5c}" (str.++ "d" (str.++ "d" (str.++ "\u{22}" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "\u{22}" (str.++ "\u{5c}" "")))(re.++ ((_ re.loop 1 3) (re.range "d" "d"))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ ((_ re.loop 1 3) (re.range "d" "d"))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ ((_ re.loop 1 3) (re.range "d" "d"))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ ((_ re.loop 1 3) (re.range "d" "d")) (re.range "\u{22}" "\u{22}")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
