;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ('((\\.)|[^\\'])*')
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\'\\u00D2\'b\u007F"
(define-fun Witness1 () String (str.++ "'" (str.++ "\u{5c}" (str.++ "\u{d2}" (str.++ "'" (str.++ "b" (str.++ "\u{7f}" "")))))))
;witness2: "\'\x6\v\'I\u0087"
(define-fun Witness2 () String (str.++ "'" (str.++ "\u{06}" (str.++ "\u{5c}" (str.++ "v" (str.++ "'" (str.++ "I" (str.++ "\u{87}" ""))))))))

(assert (= regexA (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.union (re.range "\u{00}" "&")(re.union (re.range "(" "[") (re.range "]" "\u{ff}"))))) (re.range "'" "'")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
