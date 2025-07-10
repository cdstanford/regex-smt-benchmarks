;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((^(?<property>\S+):)|(\s(?<property>)))(?<value>.*)\n
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A0\u008B\xA"
(define-fun Witness1 () String (str.++ "\u{a0}" (str.++ "\u{8b}" (str.++ "\u{0a}" ""))))
;witness2: "\xC\u00AF\u00C1\xAXm"
(define-fun Witness2 () String (str.++ "\u{0c}" (str.++ "\u{af}" (str.++ "\u{c1}" (str.++ "\u{0a}" (str.++ "X" (str.++ "m" "")))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))) (re.range ":" ":"))) (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (str.to_re "")))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.range "\u{0a}" "\u{0a}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
