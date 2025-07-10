;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = @{2}((\S)+)@{2}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00B1_\u00AD@@\u00C2\u00AC@@"
(define-fun Witness1 () String (str.++ "\u{b1}" (str.++ "_" (str.++ "\u{ad}" (str.++ "@" (str.++ "@" (str.++ "\u{c2}" (str.++ "\u{ac}" (str.++ "@" (str.++ "@" ""))))))))))
;witness2: "\x2\x13@@J\u00EA@@"
(define-fun Witness2 () String (str.++ "\u{02}" (str.++ "\u{13}" (str.++ "@" (str.++ "@" (str.++ "J" (str.++ "\u{ea}" (str.++ "@" (str.++ "@" "")))))))))

(assert (= regexA (re.++ ((_ re.loop 2 2) (re.range "@" "@"))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))) ((_ re.loop 2 2) (re.range "@" "@"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
