;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \s*("[^"]+"|[^ ,]+)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\"\u00A3\x11\"l=\u008E\u00EB"
(define-fun Witness1 () String (str.++ "\u{22}" (str.++ "\u{a3}" (str.++ "\u{11}" (str.++ "\u{22}" (str.++ "l" (str.++ "=" (str.++ "\u{8e}" (str.++ "\u{eb}" "")))))))))
;witness2: "\"\'}\"*"
(define-fun Witness2 () String (str.++ "\u{22}" (str.++ "'" (str.++ "}" (str.++ "\u{22}" (str.++ "*" ""))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.+ (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.range "\u{22}" "\u{22}"))) (re.+ (re.union (re.range "\u{00}" "\u{1f}")(re.union (re.range "!" "+") (re.range "-" "\u{ff}"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
